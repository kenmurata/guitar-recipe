class ModProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.integer :price, null: false
      t.integer :fee, null: false
      t.text :title, null: false
      t.text :paypal_product_id, null: false, unique: true
      
      t.timestamps null: false
    end
  end
end
