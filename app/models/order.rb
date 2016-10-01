class Order < ActiveRecord::Base
  has_many :line_items
  has_many :shipments
  has_many :products, through: :line_items


  def add_product(product, quantity=1)
    if line_item = line_items.find_by(product_id: product.id)
      line_item.increment(quantity)
    else
      LineItem.create(product: product)
    end
  end

  def process
    # create one shipment
    # find which warehouse can fulfill the first line item
    # assign warehouse to shipment
    # check that warehouse for other line items in shipment
    # if other line items in order -> repeat
    # if no inventory in any warehouse, raise exception
    unadded_items = assign_line_items(Shipment.create(order: self), line_items) 
    while unadded_items > 0
      unadded_items = assign_line_items(Shipment.create(order: self), unadded_items)
    end


  end

  def assign_line_items(shipment, items) 
    remainder = []

    items.each do |line_item|
      if shipment.warehouse.nil?
        if warehouse = Warehouse.find_product(line_item.product, line_item.quantity)
          shipment.warehouse = warehouse
          shipment.add(line_item.product)
        else
          raise Exception.new("This product is not in stock")
        end
      else
        if shipment.warehouse.has?(line_item.product, line_item.quantity)
          shipment.add(line_item.product)
        else
          remainder << line_item
        end
      end
    end

    remainder
  end
end
