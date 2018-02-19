class AddAddressToWarehouses < ActiveRecord::Migration
  def change
    add_column :warehouses, :address, :string
  end
end
