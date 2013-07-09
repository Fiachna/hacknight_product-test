class Product < ActiveRecord::Base
  attr_accessible :code, :description, :name

  validates :name, presence: true
  validates :code, presence: true,
  				   uniqueness: true
end