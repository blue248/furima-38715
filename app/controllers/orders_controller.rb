class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new
    redirect_to root_path if @item.user_id == current_user.id
  end

  def create
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      @order_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_destination).permit(:post_code, :prefecture_id, :city, :block, :building_name, :phone_no).merge(
      user_id: current_user.id, item_id: @item.id
    )
  end
end
