class Package < ActiveRecord::Base
  belongs_to :customer

  STATUS = {undelivered: 1, in_transit: 2, delivered: 2}

  validates :customer_id, :description, :quantity, :value, :dimensions_unit, 
            :commodity_code, :destination_customer_id, :status, presence: true

  def self.in_transit_for_zipcode(code)
    Package.joins(:customer).where(status: STATUS[:in_transit]).where("customer.zipcode = ?", code)
  end
end
