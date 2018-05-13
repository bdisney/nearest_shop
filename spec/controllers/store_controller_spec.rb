require 'rails_helper'

RSpec.describe StoreController, type: :controller do
  describe 'GET#index' do
    # before { get :index }
    let(:position_params) { params[:position] = { latitude: '90', longitude: '180' } }


    it 'renders index view' do
      get :index
      expect(response).to render_template :index
    end

    context 'with various params' do
      let(:request_with_position) {
        process :index, method: :get, params: {
          position: { latitude: '55.755826', longitude: '37.6172999' }
        }
      }

      let(:request_selected_shop) {
        process :index, method: :get, params: {
            selected_shop: { shop_id: 66 }
        }
      }

      let!(:shop_with_position) { create(:shop) }
      let!(:selected_shop)      { create(:shop, id: 66) }

      it 'assigns shop with nearest passed position to @shop' do
        request_with_position
        expect(assigns(:shop).id).to equal(shop_with_position.id)
      end

      it 'assigns shop founded by passed shop_id to @shop' do
        request_selected_shop
        expect(assigns(:shop).id).to equal(selected_shop.id)
      end

      it 'assigns shop founded by lat long from cookies to @shop' do
        cookies['latitude']  = '55.755826'
        cookies['longitude'] = '37.6172999'

        get :index
        expect(assigns(:shop).id).to equal(shop_with_position.id)
      end
    end
  end
end
