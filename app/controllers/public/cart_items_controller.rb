class Public::CartItemsController < ApplicationController
  def index
    @cart_items = Cart_Item.all
  end

  def create
    @cart_item = current_customer.cart_item.build(cart_item_params)
    @cart_item.save
    redirect_to "/public/cart_items"
  end

  private

  def cart_item_params
    params.permit(:item_id, :amount)
  end
end
