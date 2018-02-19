class AddDestinationToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :destination, :string
  end
end
