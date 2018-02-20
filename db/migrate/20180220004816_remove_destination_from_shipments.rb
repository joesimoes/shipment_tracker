class RemoveDestinationFromShipments < ActiveRecord::Migration
  def change
    remove_column :shipments, :destination, :string
  end
end
