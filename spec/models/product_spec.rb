require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of :name }
  it { should have_many :products_shops }
  it { should have_many(:shops).through(:products_shops) }
end
