class Product < ActiveRecord::Base
  enum product_cycle: [ :to_buy, :stock, :no_more ]
  belongs_to :user
end
