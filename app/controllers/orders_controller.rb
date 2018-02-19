class OrdersController < ApplicationController
  def index
    @unprocessed_orders = Order.includes(:shipments).where(shipments: {order_id: nil}).prioritized
    @processed_orders = Order.joins(:shipments).group('orders.id').having('count(order_id) > 0').prioritized
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.create
    @product = Product.find(params[:order][:product_ids].to_i)
    @order.add_product(@product, params[:order][:line_items].to_i)
    @order.process

    redirect_to action: "index", flash: {notice: "Order created."}
  end

  def show
    @order = Order.find(params[:id])
  end

  def allowed_params
    params.require(:order).permit(line_item_ids: [])
  end
end
