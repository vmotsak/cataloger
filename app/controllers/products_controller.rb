class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy, :mark_as_pro, :buy]

  def index
    respond_with @products = policy_scope(Product)
  end

  def show
    respond_with(@product)
  end

  def new
    respond_with @product = Product.new(shop_name: current_user.shop_name)
  end

  def edit
    respond_with(@product)
  end

  def create
    @product = current_user.products.create(product_params.merge(shop_name: current_user.shop_name))
    respond_with(@product, location: products_path)
  end

  def mark_as_pro
    authorize @product
    @product.update(is_pro: true)
    respond_with(@product, location: products_path)
  end

  def buy
    authorize @product
    purchase_service = PurchaseService.new(current_user)
    purchase_service.buy @product
    if purchase_service.error
      flash[:error] = purchase_service.error
    else
      flash[:notice] = 'Product purchased'
    end
    redirect_to products_path
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
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :description, :photo)
  end
end
