require 'feature_spec_helper'

feature 'User can select shop', %q{
  In order to buy something from shop near me
  As an user
  I want to be able select shop
} do

  given!(:default_shop) { create(:shop, :default) }
  given!(:shop)         { create(:shop, city: 'Orenburg') }


  scenario 'User visit app first time', js: true do
    visit store_path

    expect(page).to have_select('shops')
    expect(page).to have_content(default_shop.full_address)
    expect(page).to_not have_content(shop.full_address)

    select shop.full_address, from: 'shops'
    expect(page).to have_content(shop.full_address)
    expect(page).to_not have_content(default_shop.full_address)
  end

  scenario 'App memorize selected shop', js: true do
    visit store_path

    expect(page).to have_content(default_shop.full_address)
    within('.js-store') do
      expect(page).to_not have_content(shop.full_address)
    end

    select shop.full_address, from: 'shops'

    within('.js-store') do
      expect(page).to have_content(shop.full_address)
    end

    page.refresh

    within('.js-store') do
      expect(page).to have_content(shop.full_address)
    end
    expect(find(:css, '#shops').value).to eq(shop.id.to_s)
  end
end
