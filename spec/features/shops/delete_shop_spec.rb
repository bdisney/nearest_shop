require 'feature_spec_helper'

feature 'Someone can destroy shop', %q{
  In order to destroy shop
  As someone
  I want to be able to do it
} do

  given!(:shop) { create(:shop) }

  scenario 'Someone tries destroy shop and cofirm destroy action' do
    visit shops_path

    expect(page).to have_content(shop.full_address)

    find('tr', id: shop.id.to_s).click_link(I18n.t('buttons.destroy'))

    expect(current_path).to eq shops_path
    expect(page).to_not have_content(shop.full_address)
    expect(page).to have_content(I18n.t('activerecord.notices.deleted'))
  end
end
