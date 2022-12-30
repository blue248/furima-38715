require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_destination = FactoryBot.build(:order_destination, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '配送先情報の保存' do
    context '配送先情報を保存できる場合' do
      it '全ての値が正しく入力されている場合は保存できる' do
        expect(@order_destination).to be_valid
      end

      it 'building_nameは空でも保存できる' do
        @order_destination.building_name = ''
        expect(@order_destination).to be_valid
      end
    end

    context '配送先情報を保存できない場合' do
      it 'userと紐付いていなければ保存できない' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Userを入力してください')
      end

      it 'itemと紐付いていなければ保存できない' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Itemを入力してください')
      end

      it 'tokenが空では保存できない' do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('クレジットカード情報を入力してください')
      end

      it 'post_codeが空では保存できない' do
        @order_destination.post_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('郵便番号を入力してください', '郵便番号半角数字とハイフンを用いて入力してください (例： 123-4567)')
      end

      it 'post_codeに半角のハイフンを含んだ正しい形式でないと保存できない' do
        @order_destination.post_code = 1_234_567
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('郵便番号半角数字とハイフンを用いて入力してください (例： 123-4567)')
      end

      it 'prefecture_idが1では保存できない' do
        @order_destination.prefecture_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('都道府県を選択してください')
      end

      it 'cityが空では保存できない' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('市区町村を入力してください')
      end

      it 'blockが空では保存できない' do
        @order_destination.block = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('番地を入力してください')
      end

      it 'phone_noが空では保存できない' do
        @order_destination.phone_no = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('電話番号を入力してください', '電話番号は半角数字のみで入力してください')
      end

      it 'phone_noが10桁より少ないと保存できない' do
        @order_destination.phone_no = Faker::Number.number(digits: 9)
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('電話番号は半角数字のみで入力してください')
      end

      it 'phone_noが11桁より多いと保存できない' do
        @order_destination.phone_no = "0#{Faker::Number.decimal_part(digits: 11)}"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('電話番号は半角数字のみで入力してください')
      end

      it 'phone_noに全角数字が含まれると保存できない' do
        @order_destination.phone_no = '０９０１２３４５６７８'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('電話番号は半角数字のみで入力してください')
      end

      it 'phone_noに文字が含まれると保存できない' do
        @order_destination.phone_no = '090-1234-5678'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('電話番号は半角数字のみで入力してください')
      end
    end
  end
end
