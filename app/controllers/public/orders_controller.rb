class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @orders = current_customer.orders
    @order = Order.find(params[:id])
    @order_lists = @order.order_lists
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
    cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    if @order.save
      cart_items.each do |cart_item|
        order_list = OrderList.new
        order_list.item_id = cart_item.item_id
        order_list.order_id = @order.id
        order_list.amount = cart_item.amount
        order_list.price = cart_item.item.price
        order_list.making_status = 0
        order_list.save
      end
      current_customer.cart_items.destroy_all
      redirect_to "/orders/complete"
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_fee, :total_payment, :payment_method, :status)
  end

end
