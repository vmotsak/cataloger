class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    respond_with @products = current_user.products.all
  end

  def show
    respond_with(@product)
  end

  def new
    respond_with @product = Product.new
  end

  def edit
    respond_with(@product)
  end

  def create
    respond_with(@product = current_user.products.create(product_params))
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    respond_with(@product.destroy)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = current_user.products.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :description, :photo)
  end
end
