# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

    product = Product.create(name: "4K Television")
    warehouse = Warehouse.create(address: "100 Broadway New York, NY 10010")
    inventory = Inventory.create(product_id: product.id, warehouse_id: warehouse.id, quantity: 10)
    order = Order.create
