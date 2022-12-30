class OrderDestination
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :block, :building_name, :phone_no, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: '半角数字とハイフンを用いて入力してください (例： 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :city, presence: { message: 'を入力してください' }
    validates :block, presence: { message: 'を入力してください' }
    validates :phone_no, format: { with: /\A\d{10,11}\z/, message: 'は半角数字のみで入力してください' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, block: block,
                       building_name: building_name, phone_no: phone_no, order_id: order.id)
  end
end
