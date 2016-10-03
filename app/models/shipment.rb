class Shipment < ActiveRecord::Base
  belongs_to :order
  belongs_to :warehouse
  has_many :product_shipments
  has_many :products, through: :product_shipments

  def add(product)
    products << product
  end
end
