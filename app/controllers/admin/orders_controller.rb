class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.find(params[:id])
    @order = Order.find(params[:id])
    @order_lists = @order.order_lists
    @order_list = OrderList.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_fee, :total_payment, :payment_method, :status)
  end
end