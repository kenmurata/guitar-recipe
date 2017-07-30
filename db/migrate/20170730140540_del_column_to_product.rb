class DelColumnToProduct < ActiveRecord::Migration
  def down
    del_column :products, :fee
  end
  def up
    add_column :purchases, :fee, :integer
  end
end
