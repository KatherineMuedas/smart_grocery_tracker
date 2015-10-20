class ProductsController < ApplicationController
  def index
    # Create your list consisting of all active products to buy
    smart_listing_create :products, Product.active, partial: "products/products_to_buy_list"
  end
end
