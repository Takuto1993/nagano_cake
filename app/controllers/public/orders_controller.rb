class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @cart_items = current_customer.cart_items
  end

  def show
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to '/orders'
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_fee, :total_payment, :payment_method, :status)
  end

end
