class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy]

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
      redirect_to products_path, notice: 'Saved'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
  end

  private

  def product_params
    params.require(:product).permit(:id, :name)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
