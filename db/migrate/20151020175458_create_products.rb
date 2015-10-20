class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_type
      t.string :unit_measurement
      t.string :store
      t.integer :product_cycle, default: 0, null: false 
      t.integer :quantity, default: 0, null: false 
      t.date :expiration_date
      t.date :purchase_date
      t.float :price
      t.float :unit_price
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
