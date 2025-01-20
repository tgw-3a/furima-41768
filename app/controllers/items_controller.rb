class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @items = Item.order(id: 'DESC')
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :price, :description, :category_id, :condition_id, :shipping_fee_burden_id,
                                 :prefecture_id, :shipping_date_estimate_id).merge(user_id: current_user.id)
  end

  def correct_user
    if user_signed_in?
      @item = Item.find(params[:id])
      redirect_to root_path unless @item.user_id == current_user.id
    else
      redirect_to new_user_session_path
    end
  end
end
