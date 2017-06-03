class ChangeColumnProducts < ActiveRecord::Migration
  def change
    add_column :products, :category, :string
    add_column :products, :release, :date
  end
end
