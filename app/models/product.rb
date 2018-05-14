class Product < ApplicationRecord
  has_many :products_shops, dependent: :destroy
  has_many :shops, through: :products_shops

  validates :name, presence: true
end
