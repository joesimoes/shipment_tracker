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
    params[:order].each do |order|
      product = Product.find(order[:product_ids].to_i)
      @order.add_product(product, order[:line_items].to_i)
    end
    @order.process
    @order.update(destination: params[:order].last["destination"])

    redirect_to action: "index", flash: {notice: "Order created."}
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:destination, product_ids: [], line_items: [])
  end
end
