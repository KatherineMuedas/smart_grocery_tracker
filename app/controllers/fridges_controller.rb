class FridgesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_filter :find_product, only: [:edit, :update, :destroy]
  def index
    session[:selected_products] = {} if params[:clear]
    products_scope = Product.where(product_cycle: 1)
    products_scope = products_scope.where('name ilike ?', "%#{params[:filter]}%") if params[:filter]
    @products = smart_listing_create(:products_stock, products_scope, partial: "fridges/products_stock_list", default_sort: {name: "asc"})
    set_selected_products
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

  def move_to_list
    if params[:id]
      @products_stock = Product.where(id: params[:id])
    else
      @products_stock = Product.where(id: session[:selected_products].try(:keys))
      session[:selected_products] = {}
    end

    @products_stock.update_all(product_cycle: 0)

    set_selected_products
  end

  def select_products_to_list
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
    params.require(:product).permit(:name, :product_type, :product_cycle, :quantity, :unit_measurement,:expiration_date, :store, :price, :unit_price, :purchase_date, :user_id)
  end

  def set_selected_products
    @selected_products = Product.where(product_cycle: 1).where(id: session[:selected_products].try(:keys))
  end
end










