require 'rails_helper'

RSpec.describe ShopsController, type: :controller do

  let(:shop)  { create(:shop) }
  let(:shop1) { create(:shop) }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:create_process) {
        process :create, method: :post, params: { shop: attributes_for(:shop) }
      }

      it 'it saves new shop to db' do
        expect { create_process }.to change(Shop, :count).by(1)
      end

      it 'redirect to list of shops' do
        create_process
        expect(response).to redirect_to shops_path
      end
    end

    context 'with invalid attributes' do
      let(:invalid_create_process) {
        process :create, method: :post, params: { shop: attributes_for(:shop, :invalid) }
      }

      it 'does not save new product to db' do
        expect { invalid_create_process }.to_not change(Product, :count)
      end

      it 're-renders shop#new view' do
        invalid_create_process
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH#update' do
    context 'with valid attributes' do
      before do
        process :update, method: :patch, params: {
          id: shop, shop: attributes_for(:shop)
        }
      end

      it 'assigns the requested shop to @shop' do
        expect(assigns(:shop)).to eq shop
      end

      it 'changes shop attributes' do
        process :update, method: :patch, params: {
          id: shop, shop: { city: 'edited city' }
        }
        shop.reload
        expect(shop.city).to eq 'edited city'
      end

      it 'redirect to show view' do
        expect(response).to redirect_to shop
      end
    end

    context 'with invalid attributes' do
      it 'does not change shop attributes' do
        process :update, method: :patch, params: {
          id: shop, shop: { city: nil }
        }

        shop.reload
        expect(shop.city).to eq 'Moscow'
      end
    end

    context 'with valid nested attributes' do
      let(:product)       { create(:product) }
      let(:products_shop) { build(:products_shop) }

      it 'saves nested products_shops attributes to db' do
        expect {
          post :update, params: {
            id: shop, shop: attributes_for(
              :shop,
              products_shops_attributes: attributes_for(
                :products_shop, product_id: product, id: products_shop
              )
            )
          }
        }.to change(ProductsShop, :count).by(1)
      end
    end

    context 'with invalid nested attributes' do
      let(:product)       { create(:product) }
      let(:products_shop) { build(:products_shop) }

      it ' do not saves nested products_shops attributes to db' do
        expect {
          post :update, params: {
              id: shop, shop: attributes_for(
                  :shop,
                  products_shops_attributes: attributes_for(
                      :products_shop, product_id: product, id: products_shop, price: nil
                  )
              )
          }
        }.to_not change(ProductsShop, :count)
      end
    end
  end

  describe 'DELETE#destroy' do
    let!(:shop) { create(:shop) }
    let(:delete_process) {
      process :destroy, method: :delete, params: { id: shop.id}
    }
    it 'deletes shop from db' do
      expect { delete_process }.to change(Shop, :count).by(-1)
    end

    it 'redirects to shops path' do
      delete_process
      expect(response).to redirect_to shops_path
    end
  end
end
