class ChangeColumnToPaypal < ActiveRecord::Migration
  def up
    add_column :paypals, :transaction_type, :text
  end
  
  def down
    del_column :paypals, :type, :text
  end
end
