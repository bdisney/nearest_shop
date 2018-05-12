class Shop < ApplicationRecord
  geocoded_by :full_address
  validates :city, :street, :zip, presence: true
  after_validation :geocode, if: :address_attributes_changed?

  scope :default, -> { where(default_for_all: true).first }

  def full_address
    [city, street, zip].compact.join(', ')
  end

  def address_attributes_changed?
    %w[city street zip].each do |attr|
      return true if send(attr).present? && send("#{attr}_changed?")
    end
    return false
  end
end
