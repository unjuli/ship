class Zipcode < ActiveRecord::Base
  
  SPECIAL_CODES = [98001, 93725, 80238, 17339]
  
  belongs_to :city
  has_many :customers, class_name: Customer.name, foreign_key: :code

  validates :code, :location, :weekday_enabled, presence: true

  after_save :send_special_notification, if :special_code_enabled_for_saturday?
  after_save :notify_affected_customers, if Proc.new{|zipcode| zipcode.saturday_enabled_changed?}

  def enable_saturday_delivery
    self.update(saturday_enabled: true)
  end

  def disable_saturday_delivery
    self.update(saturday_enabled: false)
  end

  # cache all zipcodes
  def self.list_all
    Rails.cache.fetch("zipcode-all") do
      Zipcode.all
    end
  end

  def send_special_notification
    DeliveryReportMailer.special_saturday_delivery_report(self.code)
  end

  private

  def special_code_enabled_for_saturday?
    self.saturday_enabled_changed? && self.saturday_enabled && SPECIAL_CODES.include?(self.code)
  end

  def notify_affected_customers
    packages_affected = Package.in_transit_for_zipcode(self.code)
    if self.saturday_enabled
      DeliveryStatusMailer.saturday_enable_notification(packages_affected)
    else
      DeliveryStatusMailer.saturday_disable_notification(packages_affected)
    end
  end

  # == Schema Information
  #
  # Table name: zipcodes
  #
  #  id                         :integer          not null, primary key
  #  city_id                    :integer
  #. code                       :integer 
  #  location                   :varchar(255)
  #  weekday_enabled            :boolean
  #  saturday_enabled           :boolean
end
