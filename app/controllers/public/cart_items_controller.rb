class Public::CartItemsController < ApplicationController
  def index
    @cart_items = Cart_Item.all
  end

  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_item.save
    binding.pry
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
