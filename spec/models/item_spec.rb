require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品を出品できる場合' do
      it 'image、name、description、priceが存在し、category_id、condition_id、shipping_charge_id、prefecture_id、shipping_day_idが1以外であり、priceが半角数字であり、¥300〜9999999の範囲である' do
        expect(@item).to be_valid
      end
    end

    context '商品を出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品画像を入力してください')
      end

      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end

      it 'descriptionが空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品説明を入力してください')
      end

      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('価格を入力してください', '価格は半角数字で入力してください', '価格が設定範囲外です')
      end

      it 'priceに全角数字が含まれていると出品できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角数字で入力してください', '価格が設定範囲外です')
      end

      it 'priceに全角文字が含まれていると出品できない' do
        @item.price = 'あああああ'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角数字で入力してください', '価格が設定範囲外です')
      end

      it 'priceに半角文字が含まれていると出品できない' do
        @item.price = 'aaaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角数字で入力してください', '価格が設定範囲外です')
      end

      it 'priceが¥300未満では出品できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格が設定範囲外です')
      end

      it 'priceが¥9999999より多い場合は出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格が設定範囲外です')
      end

      it 'category_idが1では出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end

      it 'condition_idが1では出品できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end

      it 'shipping_charge_idが1では出品できない' do
        @item.shipping_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end

      it 'prefecture_idが1では出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('都道府県を選択してください')
      end

      it 'shipping_day_idが1では出品できない' do
        @item.shipping_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end

      it 'userが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
