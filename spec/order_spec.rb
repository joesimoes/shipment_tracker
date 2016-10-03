require "spec_helper"
require "rails_helper"
require "pry"

RSpec.describe "Order" do
  let!(:product_a)          { Product.create }
  let!(:product_b)          { Product.create }

  let!(:warehouse_a)        { Warehouse.create }
  let!(:warehouse_b)        { Warehouse.create }

  let!(:inventory_a)        { Inventory.create product_id: product_a.id, warehouse_id: warehouse_a.id, quantity: 10 }
  let!(:inventory_b)        { Inventory.create product_id: product_a.id, warehouse_id: warehouse_b.id, quantity: 10 }
  let!(:inventory_c)        { Inventory.create product_id: product_b.id, warehouse_id: warehouse_b.id, quantity: 10 }

  let(:order) { Order.create }

  describe "#add_product" do
    context "empty order" do
      it "should create a line item" do
        expect{ order.add_product(product_a, 1) }.to change(LineItem, :count)
      end
    end

    context "order with existing product" do
      before do
        order.add_product(product_a, 1)
      end

      it "changes the quantity on an existing line item" do
        order.add_product(product_a, 1)
        expect(order.line_items.first.quantity).to eq 2
      end
    end

    context "no quantity is passed" do
      it "should default to a quantity of 1" do 
        order.add_product(product_a)
        expect(order.line_items.first.quantity).to eq 1 
      end
    end
  end

  describe "#process" do
    describe "single item order" do

      before do 
        order.add_product(product_a, 1)
        order.process
      end

      it "has one shipment" do
        expect(order.shipments.count).to eq 1
      end

      it "ships from the expected warehouse" do
        expect(order.shipments.last.warehouse).to be_present 
      end
    end

    describe "multiple item order, single warehouse" do
      before do 
        order.add_product(product_a, 1)
        order.add_product(product_b, 1)
        inventory_a.update(quantity: 0)

        order.process
      end
      

      context "warehouse with full shipment inventory" do
        it "has one shipment" do
          expect(order.shipments.count).to eq 1
        end

        it "ships both products from the same warehouse" do
          expect(order.shipments.collect(&:warehouse).uniq).to eq([warehouse_b])
        end
      end
    end

    describe "multiple item order, multiple warehouses" do
      before do 
        order.add_product(product_a, 1)
        order.add_product(product_b, 1)
        inventory_b.update(quantity: 0)

        order.process
      end

      it "has two shipments" do
        expect(order.shipments.count).to eq 2 
      end

      it "ships from multiple warehouses" do
        expect(order.shipments.collect(&:warehouse).count).to eq 2

      end
    end

    describe "no warehouse has sufficient quantity" do
      let(:product_c) { Product.create }

      before do
        order.add_product(product_c, 1)
      end

      it "raises an exception" do
        expect{ order.process }.to raise_error(Exception)
      end
    end
  end
end
  
