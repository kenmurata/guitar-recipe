class AddColumnToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :user_id, :integer
    add_column :purchases, :product_id, :integer
  end
end
