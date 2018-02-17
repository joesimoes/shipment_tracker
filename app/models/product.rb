class Product < ActiveRecord::Base
  has_many :inventories
  has_many :line_items
  has_many :product_shipments
  has_many :shipments, through: :product_shipments
  has_many :warehouses, through: :inventories
  has_many :orders, through: :line_items
end
