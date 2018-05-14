require 'feature_spec_helper'

feature 'Someone can edit shop', %q{
  In order to edit ahop attributes
  As someone
  I want to be able update it
} do

  given!(:shop)    { create(:shop) }
  given!(:product) { create(:product) }


  scenario 'Someone edit shop with valid data' do
    visit edit_shop_path(shop)

    fill_in I18n.t('activerecord.attributes.shop.city'), with: 'Edited city'
    click_on I18n.t('buttons.save')

    expect(page).to have_content(I18n.t('activerecord.notices.updated'))
    expect(page).to have_content('Edited city')
    expect(current_path).to eq shop_path(shop)
  end

  scenario 'Someone tries edit shop with invalid data' do
    visit edit_shop_path(shop)

    fill_in I18n.t('activerecord.attributes.shop.city'), with: nil
    click_on I18n.t('buttons.save')

    expect(page).to have_content(I18n.t('activerecord.errors.header_title'))
    expect(current_path).to eq shop_path(shop)
  end

  scenario 'Someone add existing product to the shop', js: true do
    visit edit_shop_path(shop)

    click_on I18n.t('buttons.add_product')

    expect(page).to have_select(class: 'js-product-select')
    find('.js-product-select').select(product.name)

    fill_in I18n.t('activerecord.attributes.products_shop.price'), with: 777
    click_on I18n.t('buttons.save')

    expect(current_path).to eq shop_path(shop)
    expect(page).to have_content(I18n.t('activerecord.notices.updated'))
    expect(page).to have_content('Some name')
    expect(page).to have_content('777')
  end

  given(:shop_with_product) {
    create(:shop, :with_nested_attrs)
  }

  scenario 'Someone delete already added product from shop', js: true do
    visit shop_path(shop_with_product)

    expect(page).to have_content('Some name')
    expect(page).to have_content('123.0')

    visit edit_shop_path(shop_with_product)

    expect(page).to have_select(class: 'js-product-select')
    within('#products_shops') do
      click_on(I18n.t('buttons.destroy'))
    end
    expect(page).to_not have_select(class: 'js-product-select')

    click_on I18n.t('buttons.save')

    expect(current_path).to eq shop_path(shop_with_product)
    expect(page).to_not have_content('Some name')
    expect(page).to_not have_content('123.0')
  end
end
