require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  let(:product) { create(:product) }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:create_process) {
        process :create, method: :post, params: { product: attributes_for(:product) }
      }

      it 'it saves new product to db' do
        expect { create_process }.to change(Product, :count).by(1)
      end

      it 'redirect to list of products' do
        create_process
        expect(response).to redirect_to products_path
      end
    end

    context 'with invalid attributes' do
      let(:invalid_create_process) {
        process :create, method: :post, params: { product: attributes_for(:product, :invalid) }
      }

      it 'does not save new product to db' do
        expect { invalid_create_process }.to_not change(Product, :count)
      end

      it 're-renders products#new view' do
        invalid_create_process
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST#destroy' do
    let!(:product) { create(:product) }

    it 'deletes product from db' do
      expect { process :destroy, method: :post, params: { id: product } }
          .to change(Product, :count).by(-1)
    end
  end

  describe 'PATCH#update' do
    let(:product) { create(:product) }

    context 'with valid attributes' do
      before do
        process :update, method: :patch, params: {
          id: product, product: attributes_for(:product)
        }
      end

      it 'assigns the requested product to @product' do
        expect(assigns(:product)).to eq product
      end

      it 'changes product attributes' do
        process :update, method: :patch, params: {
            id: product, product: { name: 'edited name' }
        }
        product.reload
        expect(product.name).to eq 'edited name'
      end

      it 'render update template' do
        expect(response).to redirect_to product
      end
    end

    context 'with invalid attributes' do
      it 'does not change product attributes' do
        process :update, method: :patch, params: {
            id: product, product: { name: nil }
        }

        product.reload
        expect(product.name).to eq 'Some name'
      end
    end
  end
end