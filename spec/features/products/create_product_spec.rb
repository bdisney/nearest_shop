require 'feature_spec_helper'

feature 'Someone can create product', %q{
  In order to add product to my app
  As someone
  I want to create new product
} do

  scenario 'Someone creates product with valid data' do
    visit new_product_path

    fill_in I18n.t('activerecord.attributes.product.name'), with: 'New name'
    click_on I18n.t('buttons.save')

    expect(page).to have_content(I18n.t('activerecord.notices.cteated'))
    expect(current_path).to eq products_path
  end

  scenario 'Someone tries create product with invalid data' do
    visit new_product_path

    fill_in I18n.t('activerecord.attributes.product.name'), with: nil
    click_on I18n.t('buttons.save')

    expect(page).to have_content(I18n.t('activerecord.errors.header_title'))
    expect(current_path).to eq products_path
  end
end
