class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :order_item, only: [:index, :create]

  def index
    @order_destination = OrderDestination.new
    redirect_to root_path if @item.user_id == current_user.id

    # 商品が売却済みの時、購入パスを入力してもトップページに遷移する
    redirect_to root_path if @item.order.present?
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_destination).permit(:post_code, :prefecture_id, :city, :block, :building_name, :phone_no).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
