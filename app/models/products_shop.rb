class ProductsShop < ApplicationRecord
  belongs_to :shop
  belongs_to :product

  validates :price, presence: true
end
