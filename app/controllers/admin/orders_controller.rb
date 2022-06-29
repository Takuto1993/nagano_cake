class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.find(params[:id])
    @order = Order.find(params[:id])
    @order_lists = @order.order_lists
  end
end
