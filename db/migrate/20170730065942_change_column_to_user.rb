class ChangeColumnToUser < ActiveRecord::Migration
  def down
    del_column :users, :shipping_addres
    del_column :users, :address_second_line
  end
  def up
    add_column :users, :shipping_address, :string
    add_column :users, :address_2nd_line, :string
  end
end
