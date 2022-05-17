class Public::AddressController < ApplicationController
  def index
    @addresses = @customer.address
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to '/public/address'
  end
  
  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to '/public/address'
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to '/admin/address'
  end
  
  private
  
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
