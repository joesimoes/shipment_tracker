class CreateProductShipments < ActiveRecord::Migration
  def change
    create_table :product_shipments do |t|
      t.integer :product_id
      t.integer :shipment_id

      t.timestamps null: false
    end
  end
end
