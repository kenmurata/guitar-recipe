class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :category
      t.integer :price
      t.integer :add_price
      t.date :day
      t.integer :expense
      t.integer :income

      t.timestamps null: false
    end
  end
end
