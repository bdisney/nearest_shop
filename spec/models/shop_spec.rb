require 'rails_helper'

RSpec.describe Shop, type: :model do
  it { should validate_presence_of :city }
  it { should validate_presence_of :street }
  it { should validate_presence_of :zip }
  it { should accept_nested_attributes_for :products_shops }

  describe 'default scope' do
    let!(:shop)         { create(:shop) }
    let!(:default_shop) { create(:shop, :default) }

    it 'returns first object with default_for_all flag' do
      expect(described_class.default.id).to equal(default_shop.id)
    end
  end

  describe 'full_address' do
    let(:shop) { create(:shop) }

    it 'returns full address' do
      expect(shop.full_address).to eq('Moscow, Some street, 42, 123456')
    end
  end

  describe 'address_attributes_changed?' do
    let(:shop) { create(:shop) }

    it 'returns true if object new record' do
      shop = Shop.new
      expect(shop.address_attributes_changed?).to be_truthy
    end

    it 'returns true if city attr was changed' do
      shop.city = 'New City'
      expect(shop.address_attributes_changed?).to be_truthy
    end

    it 'returns true if street attr was changed' do
      shop.street = 'New Street'
      expect(shop.address_attributes_changed?).to be_truthy
    end

    it 'returns true if zip attr was changed' do
      shop.zip = 'New Zip'
      expect(shop.address_attributes_changed?).to be_truthy
    end

    it 'returns false if address atributes was not changed' do
      expect(shop.address_attributes_changed?).to be_falsey
    end
  end
end
