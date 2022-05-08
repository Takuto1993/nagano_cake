class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to item_params
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :is_actice)
  end

end
