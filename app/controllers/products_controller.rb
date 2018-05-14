class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def show; end
  def edit; end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: t('activerecord.notices.cteated')
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: t('activerecord.notices.updated')
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: t('activerecord.notices.deleted')
    end
  end

  private

  def product_params
    params.require(:product).permit(:id, :name)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
