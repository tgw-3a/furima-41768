require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    sleep 0.1
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品の購入' do
    context '購入処理できる場合' do
      it 'すべてのカラムに値があれば登録できる' do
        expect(@order_address).to be_valid
      end
      it 'building_nameが空でも登録できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
      it 'phone_numberは10桁でも登録できる' do
        @order_address.phone_number = '0123456789'
        expect(@order_address).to be_valid
      end
      it 'phone_numberは11桁でも登録できる' do
        @order_address.phone_number = '01234567890'
        expect(@order_address).to be_valid
      end
    end

    context '購入処理できない場合' do
      it 'userが紐づいていなければ購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていなければ購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it '出品者が自身の商品を購入しようとすると登録できない' do
        @item.update(user_id: @user.id)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't order own item")
      end
      it 'postal_codeが空だと登録できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンがないと登録できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeの左辺が2桁以下だと登録できない' do
        @order_address.postal_code = '12-4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeの左辺が4桁以上だと登録できない' do
        @order_address.postal_code = '1234-4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeの右辺が3桁以下だと登録できない' do
        @order_address.postal_code = '123-456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeの右辺が4桁以上だと登録できない' do
        @order_address.postal_code = '123-45678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it 'prefecture_idが空だと登録できない' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが0だと登録できない' do
        @order_address.prefecture_id = '0'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと登録できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと登録できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと登録できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下だと登録できない' do
        @order_address.phone_number = '012345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
      end
      it 'phone_numberが12桁以上だと登録できない' do
        @order_address.phone_number = '012345678912'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end
      it 'tokenが紐づいていないと登録できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
