class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
  end

  def show
  end

  def confirm
    #[select_address]０〜２以外を選択できてしまった場合のエラー文を入れるとさらに良い
    @order = Order.new(order_params)
     if params[:order][:select_address] == '0'
       @order.name = current_customer.last_name + current_customer.first_name
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.main_address
     elsif params[:order][:select_address] == '1'
       @address = Address.find(params[:order][:address_id])
       @order.name = @address.name
       @order.postal_code = @address.postal_code
       @order.address = @address.address
     elsif params[:order][:select_address] == '2'
       #処理無し
     end
    @cart_items = current_customer.cart_items
    @shipping_fee = 800
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to 'orders/complete'
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_fee, :total_payment, :payment_method, :status)
  end

end
