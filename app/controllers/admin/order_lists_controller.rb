class Admin::OrderListsController < ApplicationController
  def update
    @order_list = OrderList.find(params[:id])
    @order_list.update(order_params)
    redirect_to admin_order_path(order.id)
  end
  
  private
  
  def order_params
    params.require(:order_list).permit(:status)
  end
end
