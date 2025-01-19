require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    context '出品できる場合' do
      it 'すべてのカラムに値があれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it 'imageが空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'name(商品名)が空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'description(商品の説明)が空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'categoryが空だと出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'categoryが0だと出品できない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'condition(商品の状態情報)が空だと出品できない' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'condition(商品の状態情報)が0だと出品できない' do
        @item.condition_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'shipping_fee_burden(配送料の負担情報)が空だと出品できない' do
        @item.shipping_fee_burden_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee burden can't be blank")
      end
      it 'shipping_fee_burden(配送料の負担情報)が0だと出品できない' do
        @item.shipping_fee_burden_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee burden can't be blank")
      end

      it 'prefecture(発送元の地域情報)が空だと出品できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture(発送元の地域情報)が0だと出品できない' do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'shipping_date_estimate(発送までの日数情報)が空だと出品できない' do
        @item.shipping_date_estimate_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date estimate can't be blank")
      end
      it 'shipping_date_estimate(発送までの日数情報)が0だと出品できない' do
        @item.shipping_date_estimate_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date estimate can't be blank")
      end

      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceは300以下では出品できない' do
        @item.price = Faker::Number.between(from: -9_999_999, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceは0では出品できない' do
        @item.price = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceは9,999,999以下でないと出品できない' do
        @item.price = Faker::Number.between(from: 10_000_000, to: 100_000_000)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'priceが全角英数字では登録できない' do
        @item.price = '１２３４'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが漢字では登録できない' do
        @item.price = '商品価格'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceがひらがなでは登録できない' do
        @item.price = 'しょうひんかかく'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceがカタカナでは登録できない' do
        @item.price = 'ショウヒンカカク'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが半角カタカナでは登録できない' do
        @item.price = 'ｼｮｳﾋﾝｶｶｸ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
