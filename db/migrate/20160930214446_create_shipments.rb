class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.integer :warehouse_id
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
