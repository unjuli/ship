class Customer < ActiveRecord::Base
  has_many :packages
  belongs_to :zipcode, class_name: Zipcode.name, foreign_key: :code

  validates :name, :email, :phone_number, :attention_name, :address, :zipcode, presence: true
  validates :email, uniqueness: true
end
