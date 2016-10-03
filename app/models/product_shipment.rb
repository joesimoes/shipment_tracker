class ProductShipment < ActiveRecord::Base
  belongs_to :product
  belongs_to :shipment
end
