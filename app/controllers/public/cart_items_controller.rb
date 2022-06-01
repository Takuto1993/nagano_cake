class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_item.save
    redirect_to '/cart_items'
  end

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to '/cart_items'
  end

  def destroy_all
    current_cutomer.cart_items.destroy_all
    redirect_to '/cart_items'
  end

  private

  def cart_item_params
    params.permit(:item_id, :amount)
  end
end
