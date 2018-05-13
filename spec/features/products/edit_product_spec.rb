require 'feature_spec_helper'

feature 'Someone can edit product', %q{
  In order to edit info about product
  As someone
  I want to be able update it
} do

  let!(:product) { create(:product) }

  scenario 'Someone edit product with valid data' do
    visit edit_product_path(product)

    fill_in 'product[name]', with: 'Edited name'
    click_on I18n.t('buttons.save')

    expect(page).to have_content(I18n.t('activerecord.notices.updated'))
    expect(current_path).to eq product_path(product)
  end

  scenario 'Someone tries create product with invalid data' do
    visit edit_product_path(product)

    fill_in 'product[name]', with: nil
    click_on I18n.t('buttons.save')

    expect(page).to have_content(I18n.t('activerecord.errors.header_title'))
    expect(current_path).to eq product_path(product)
  end
end
