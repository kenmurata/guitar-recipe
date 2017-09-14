class ChangeColumnToProduct < ActiveRecord::Migration
  def down
    del_column :products, :price
  end
  
  def up
    add_column :products, :productgroup_id, :integer
    add_column :products, :publisher, :string
  end
end