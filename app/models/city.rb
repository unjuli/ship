class City < ActiveRecord::Base
    SPECIAL_ZIPCODES = [98001, 93725, 80238, 17339]
  
  has_many :zipcodes

  validates :name, :state, :country_code, presence: true

  # == Schema Information
  #
  # Table name: cities
  #
  #  id                         :integer          not null, primary key
  #  name                       :varchar(255)
  #  state                      :varchar(255)
  #  country_code               :varchar(2)
end
