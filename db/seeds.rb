# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

    product_one = Product.create(name: "4K Television")
    product_two = Product.create(name: "Desk")
    product_three = Product.create(name: "Sofa")

    warehouse_one = Warehouse.create(address: "2640 Steiner Street, San Francisco, CA 94016")
    warehouse_two = Warehouse.create(address: "129 West 81st Street, New York, NY 10010")

    inventory_one = Inventory.create(product_id: product_one.id, warehouse_id: warehouse_one.id, quantity: 10)
    inventory_two = Inventory.create(product_id: product_two.id, warehouse_id: warehouse_two.id, quantity: 10)
    inventory_three = Inventory.create(product_id: product_three.id, warehouse_id: warehouse_one.id, quantity: 10)


    order = Order.create
