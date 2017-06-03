class AddColumnUser < ActiveRecord::Migration
  def change
    add_column :users, :fname, :string, null: false
    add_column :users, :lname, :string, null: false
    add_column :users, :fname_kana, :string
    add_column :users, :lname_kana, :string
    add_column :users, :sex, :boolean
    add_column :users, :email1, :string, null: false
    add_column :users, :email2, :string
    add_column :users, :postal_code, :string, null: false
    add_column :users, :prefecture, :string, null: false
    add_column :users, :city, :string, null: false
    add_column :users, :tel, :string, null: false
    add_column :users, :birth, :date
    add_column :users, :history, :integer
    add_column :users, :guitar_num, :integer
    
    remove_column :users, :name, :string
    remove_column :users, :email, :string
  end
end
