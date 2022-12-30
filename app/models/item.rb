class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :shipping_day

  validates :image, :name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :shipping_day_id,
            presence: true

  validates :price, presence: true, numericality: { message: 'は半角数字で入力してください' }
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'が設定範囲外です' }

  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_charge_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_day_id, numericality: { other_than: 1, message: 'を選択してください' }
end
