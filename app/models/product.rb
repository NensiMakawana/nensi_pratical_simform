class Product < ApplicationRecord
  # validations
  validates :name, :price, presence: true
  validates_numericality_of :price
end
