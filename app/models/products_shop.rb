class ProductsShop < ApplicationRecord
  belongs_to :shop
  belongs_to :product

  validates :product_id, uniqueness: { scope: [:product_id, :shop_id] }
  validates :price, presence: true
end
