class Shop < ApplicationRecord
  geocoded_by :full_address

  has_many :products_shops, dependent: :destroy
  has_many :products, through: :products_shops

  accepts_nested_attributes_for :products_shops, reject_if: :all_blank, allow_destroy: true

  validates :city, :street, :zip, presence: true

  after_validation :geocode, if: :address_attributes_changed?

  scope :default, -> { where(default_for_all: true).first }

  def full_address
    [city, street, zip].compact.join(', ')
  end

  def address_attributes_changed?
    return true if new_record?
    %w[city street zip].each do |attr|
      return true if send(attr).present? && send("#{attr}_changed?")
    end
    return false
  end
end
