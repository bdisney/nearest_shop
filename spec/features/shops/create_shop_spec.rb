require 'feature_spec_helper'

feature 'Someone can create shop', %q{
  In order to add shop to my app
  As someone
  I want to create new shop
} do

  scenario 'Someone creates shop with valid data' do
    visit new_shop_path

    fill_in I18n.t('activerecord.attributes.shop.city'),   with: 'New city'
    fill_in I18n.t('activerecord.attributes.shop.street'), with: 'New street'
    fill_in I18n.t('activerecord.attributes.shop.zip'),    with: '123456'

    click_on I18n.t('buttons.save')

    expect(page).to have_content(I18n.t('activerecord.notices.cteated'))
    expect(current_path).to eq shops_path
  end

  scenario 'Someone tries create shop with invalid data' do
    visit new_shop_path

    fill_in I18n.t('activerecord.attributes.shop.city'), with: nil

    click_on I18n.t('buttons.save')

    expect(page).to_not have_content(I18n.t('activerecord.notices.cteated'))
    expect(current_path).to eq shops_path

    expect(page).to have_content(I18n.t('activerecord.errors.header_title'))
  end
end
