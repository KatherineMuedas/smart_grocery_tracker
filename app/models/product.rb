class Product < ActiveRecord::Base
  enum product_cycle: [ :to_buy, :stock, :no_more ]
  belongs_to :user
  PRODUCT_CATEGORIES = ["Vegetables" , "Fruits", "Frozen" , "Meat" , "Seafood" , "Herbs","Soups", "Breads", "Beverages", "Dairy", "Pantry"]
  PRODUCT_MEASUREMENTS = ["tbs" , "oz", "cups" , "lbs" ,"liters", "grams" "packages" , "bottles"]

end
