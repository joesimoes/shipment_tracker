class Inventory < ActiveRecord::Base
  belongs_to :product
  belongs_to :warehouse

  def self.locate(product, quantity)
    where("product_id = ? AND quantity >= ?", product.id, quantity).first.try(:warehouse)
  end
end
