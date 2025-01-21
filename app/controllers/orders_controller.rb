class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
    @address = Address.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      Address.create(address_params)
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def order_params
    params.permit(:item_id).merge(user_id: current_user.id)
  end

  def address_params
    params.permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(order_id: @order.id)
  end
end
