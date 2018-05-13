class Product < ApplicationRecord
  has_many :products_shops
  has_many :products, through: :products_shops

  validates :name, presence: true
end
