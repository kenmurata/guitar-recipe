class CreateProductGroups < ActiveRecord::Migration
  def change
    create_table :product_groups do |t|
      
      t.string :name, null: false
      t.integer :indicate_order, null: false

      t.timestamps null: false
    end
  end
end
