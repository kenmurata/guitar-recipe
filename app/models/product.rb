class Product < ActiveRecord::Base
  belongs_to :productgroup, class_name: 'ProductGroup', :foreign_key => 'productgroup_id'
  has_many :purchase
end
