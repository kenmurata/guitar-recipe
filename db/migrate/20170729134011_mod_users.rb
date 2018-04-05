class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :name
      t.string :email, null: false, unique: true
      t.string :shipping_addres
      t.boolean :address_status, default: false
      t.string :address_1st_line
      t.string :address_second_line
      t.string :municipality
      t.string :prefecture
      t.string :postal_code
      t.string :country_name
      t.string :country_code
      
      t.timestamps null: false
    end
  end
end
