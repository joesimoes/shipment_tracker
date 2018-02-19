class Order < ActiveRecord::Base
  has_many :line_items
  has_many :shipments
  has_many :products, through: :line_items

  def add_product(product, quantity=1)
    if line_item = line_items.find_by(product_id: product.id)
      line_item.increment(quantity)
    else
      line_items.create(product: product, quantity: quantity)
    end
  end

  def process
    unadded_items = assign_line_items(Shipment.create(order: self), line_items)

    while unadded_items.count > 0
      unadded_items = assign_line_items(Shipment.create(order: self), unadded_items)
    end
  end

  def self.prioritized
    order('orders.created_at')
  end

  private

  def assign_line_items(shipment, items)
    remainder = []

    items.each do |line_item|
      if shipment.warehouse.nil?
        find_warehouse(shipment, line_item)
      else
        remainder << line_item unless add_to_shipment(shipment, line_item)
      end
    end
    remainder
  end

  def find_warehouse(shipment, line_item)
    if warehouse = Inventory.locate(line_item.product, line_item.quantity)
      shipment.update(warehouse_id:  warehouse.id)
      shipment.add(line_item.product)
      warehouse
    else
      raise Exception.new("This product is not in stock")
    end
  end

  def add_to_shipment(shipment, line_item)
    if shipment.warehouse.has?(line_item.product, line_item.quantity)
      shipment.add(line_item.product)
      true
    else
      false
    end
  end
end
