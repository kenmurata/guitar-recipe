class AddColumnUsers < ActiveRecord::Migration
  def change
    add_column :users, :genre, :text
  end
end
