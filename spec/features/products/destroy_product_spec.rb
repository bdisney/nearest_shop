require 'feature_spec_helper'

feature 'Someone can destroy product', %q{
  In order to destroy product
  As someone
  I want to be able to do it
} do

  given!(:product) { create(:product) }

  scenario 'Someone tries destroy product and cofirm destroy action' do
    visit products_path

    expect(page).to have_content(product.name)

    find('tr', id: product.id.to_s).click_link(I18n.t('buttons.destroy'))

    expect(current_path).to eq products_path
    expect(page).to_not have_content(product.name)
    expect(page).to have_content(I18n.t('activerecord.notices.deleted'))
  end
end
