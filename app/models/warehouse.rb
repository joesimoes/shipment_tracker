class Warehouse < ActiveRecord::Base
  has_many :inventories
  has_many :shipments
  has_many :products, through: :inventories

  
  def has?(product, qty)
    inventories.where("product_id = ? AND quantity >= ?", product.id, qty).present?
  end
end
