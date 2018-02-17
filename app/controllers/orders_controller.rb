class OrdersController < ApplicationController
  def index
    @unprocessed_orders = Order.includes(:shipments).where(shipments: {order_id: nil})
    @processed_orders = Order.joins(:shipments).group('orders.id').having('count(order_id) > 0')
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.create
    @product = Product.find(params[:order][:product_ids].to_i)
    @order.add_product(@product, params[:order][:line_items].to_i)
    @order.process

    redirect_to action: "index"
  end

  def allowed_params
    params.require(:order).permit(:email, :password, :password_confirmation, event_ids: [])
  end

end
