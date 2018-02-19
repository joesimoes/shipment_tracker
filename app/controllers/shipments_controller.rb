class ShipmentsController < ApplicationController
  def index
    @shipments = Shipment.prioritized_list
  end

  def allowed_params
    params.require(:order).permit(:email, :password, :password_confirmation, event_ids: [])
  end
end
