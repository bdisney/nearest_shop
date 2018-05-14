class ShopsController < ApplicationController
  helper_method :products_for_select

  before_action :set_shop, only: %i[edit update show destroy]

  def new
    @shop = Shop.new
  end

  def show; end

  def index
    @shops = Shop.all
  end

  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      redirect_to shops_path, notice: t('activerecord.notices.cteated')
    else
      render :new
    end
  end

  def update
    if @shop.update(shop_params)
      redirect_to @shop, notice: t('activerecord.notices.updated')
    else
      render :edit
    end
  end

  def destroy
    if @shop.destroy
      redirect_to shops_path, notice: t('activerecord.notices.deleted')
    end
  end

  private

  def shop_params
    params.require(:shop).permit(
      :id, :city, :street, :zip, :latitude, :longitude, :default_for_all,
      products_shops_attributes: [:id, :product_id, :price, :_destroy]
    )
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def products_for_select
    Product.all.map { |p| [p.name, p.id] }
  end
end
