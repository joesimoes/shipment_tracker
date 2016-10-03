## Setup
* Setup will require a `bundle install` followed by a `rake db:setup`. The tests can be run with `rspec`.

## Models

* Products, Shipments, Warehouses and Orders are the primary data models.
* A shipment represents a group of products sent from a warehouse.
* A warehouse contains inventory, which represents products with a quantity.
* An order interacts with products and gives a more comprehensive view of warehouses, inventory and shipments.
* Products are represented on an order as line items, which also have a quantity.

## Function

* The majority of the processing algorithm and shipment parsing occurs in `Order#process`.
* This method recursively creates shipments based on the order's line items.
* Each shipment has an associated warehouse which is determined by finding a warehouse with sufficient inventory of the given product.
* Currently, the algorithm is not optimized for picking the best case warehouse but follows a FIFO pattern. It could be further optimized to pick the best warehouse to fulfill the entire order, rather than finding the first warehouse to fulfill a line item quantity.
* Developed a basic DSL for Line Item management to make the tests more readable and provide a basic interface.
 
## Scenarios

The primary cases I was developing for:
* Order with one product is processed resulting in one shipment from one warehouse with inventory
* Order with two different products is processed resulting in one shipment from one warehouse with inventory
* Order with two different products is processed resulting in two shipments from two warehouses with inventory
* Warehouse A with inventory for product A is 1, order with product A in quantity of 2. Shipment is generated for warehouse B if sufficient quantity
* Exception is raised with custom message when no inventory available in any warehouse.
