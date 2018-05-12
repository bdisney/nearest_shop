class StoreController < ApplicationController
  DISTANCE = 500.freeze

  before_action :set_shop
  before_action :set_shops, only: :index

  def index
    respond_to do |format|
      format.js   { render 'index.js.erb' }
      format.html {}
    end
  end

  private

  def set_shop
    @shop =
      if position = params[:position]
        Shop.near([position[:latitude], position[:longitude]], DISTANCE).first
      elsif params[:selected_shop]
        shop = Shop.find(params[:selected_shop][:shop_id])
        update_cookies(shop) && shop if shop
      else
        lat  = cookies['latitude']
        long = cookies['longitude']

        Shop.near([lat, long], DISTANCE).first || Shop.default
      end
  end

  def set_shops
    @shops = Shop.all.map { |shop| [shop.full_address, shop.id] }
  end

  def update_cookies(shop)
    cookies['latitude']  = shop.latitude
    cookies['longitude'] = shop.longitude
  end
end
