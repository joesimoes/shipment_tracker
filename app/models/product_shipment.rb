class ProductShipment < ActiveRecord::Base
  belongs_to :products
  belongs_to :shipments
end
