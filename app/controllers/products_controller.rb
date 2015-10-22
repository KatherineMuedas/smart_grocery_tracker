class ProductsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  before_filter :find_product, except: [:index, :new, :create]
  def index
    products_scope = Product.where(product_cycle: 0)
    products_scope = products_scope.where('name ilike ?', "%#{params[:filter]}%") if params[:filter]
    @products = smart_listing_create(:products_to_buy, products_scope, partial: "products/products_to_buy_list", default_sort: {name: "asc"})
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.create(product_params)
    # if @product.save
    #   redirect_to products_path, notice: 'Successfully created.'
    # else
    #   render 'new', alert: 'Error'
    # end
  end

  def edit
  
  end

  def update
    @product.update_attributes(product_params)
  end

  def destroy
    @product.destroy
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :product_type, :product_cycle, :quantity, :unit_measurement, :store, :price, :unit_price, :purchase_date, :user_id)
  end

end









