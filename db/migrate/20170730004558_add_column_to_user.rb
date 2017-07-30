class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :telephone_number, :string
  end
end
