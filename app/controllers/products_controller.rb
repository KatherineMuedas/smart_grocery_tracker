class ProductsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  before_filter :find_product, only: [:edit, :update, :destroy]
  def index
    session[:selected_products] = {} if params[:clear]
    products_scope = Product.where(product_cycle: 0)
    products_scope = products_scope.where('name ilike ?', "%#{params[:filter]}%") if params[:filter]
    @products = smart_listing_create(:products_to_buy, products_scope, partial: "products/products_to_buy_list", default_sort: {name: "asc"})
    
    set_selected_products
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.create(product_params)
  end

  def edit
  end

  def update
    @product.update_attributes(product_params)
  end

  def destroy
    @product.destroy
  end

  def move_to_inventory
    if params[:id]
      @products_to_buy = Product.where(id: params[:id])
    else
      @products_to_buy = Product.where(id: session[:selected_products].try(:keys))
      session[:selected_products] = {}
    end

    @products_to_buy.update_all(product_cycle: 1)

    set_selected_products
  end

  def select_products
    params[:product_selection].each do |key, value|
      if value == "true"
        session[:selected_products] ||= {}
        session[:selected_products][key] = 1
      else
        session[:selected_products].delete(key)
      end
    end

    set_selected_products
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :product_type, :product_cycle, :quantity,:expiration_date, :unit_measurement, :store, :price, :unit_price, :purchase_date, :user_id)
  end

  def set_selected_products
    @selected_products = Product.where(product_cycle: 0).where(id: session[:selected_products].try(:keys))
  end

end









