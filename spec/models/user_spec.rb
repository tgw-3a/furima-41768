require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'すべてのカラムに値があれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordは半角英数字混合で登録できる' do
        @user.password = 'Test321'
        @user.password_confirmation = 'Test321'
        expect(@user).to be_valid
      end
      it 'last_nameとfirst_nameは漢字で登録できる' do
        @user.last_name = '山田'
        @user.first_name = '陸太郎'
        expect(@user).to be_valid
      end
      it 'last_nameとfirst_nameはひらがなで登録できる' do
        @user.last_name = 'やまだ'
        @user.first_name = 'りくたろう'
        expect(@user).to be_valid
      end
      it 'last_nameとfirst_nameは全角カタカナで登録できる' do
        @user.last_name = 'ヤマダ'
        @user.first_name = 'リクタロウ'
        expect(@user).to be_valid
      end
      it 'last_name_kanaとfirst_name_kanaは全角カタカナで登録できる' do
        @user.last_name_kana = 'ヤマダ'
        @user.first_name_kana = 'リクタロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '登録済みのemailでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは5文字以下だと登録できない' do
        @user.password = 'Test1'
        @user.password_confirmation = 'Test1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは129文字以上だと登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'Testtest'
        @user.password_confirmation = 'Testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain both letters and numbers')
      end
      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain both letters and numbers')
      end
      it 'passwordが全角英数字では登録できない' do
        @user.password = 'Ｐａｓｓ１２３４'
        @user.password_confirmation = 'Ｐａｓｓ１２３４'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain both letters and numbers')
      end
      it 'passwordが漢字では登録できない' do
        @user.password = '合言葉'
        @user.password_confirmation = '合言葉'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain both letters and numbers')
      end
      it 'passwordがひらがなでは登録できない' do
        @user.password = 'あいことば'
        @user.password_confirmation = 'あいことば'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain both letters and numbers')
      end
      it 'passwordがカタカナでは登録できない' do
        @user.password = 'アイコトバ'
        @user.password_confirmation = 'アイコトバ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain both letters and numbers')
      end
      it 'passwordが半角カタカナでは登録できない' do
        @user.password = 'ｱｲｺﾄﾊﾞ'
        @user.password_confirmation = 'ｱｲｺﾄﾊﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain both letters and numbers')
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = 'Test123'
        @user.password_confirmation = 'Test234'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameは英字では登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'last_nameは数字では登録できない' do
        @user.last_name = '1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'last_nameは半角カタカナでは登録できない' do
        @user.last_name = 'ｶﾀｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end

      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameは英字では登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'first_nameは数字では登録できない' do
        @user.first_name = '1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'first_nameは半角カタカナでは登録できない' do
        @user.first_name = 'ｶﾀｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end

      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaは英字では登録できない' do
        @user.last_name_kana = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width characters.')
      end
      it 'last_name_kanaは数字では登録できない' do
        @user.last_name_kana = '1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width characters.')
      end
      it 'last_name_kanaは漢字では登録できない' do
        @user.last_name_kana = '漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width characters.')
      end
      it 'last_name_kanaはひらがなでは登録できない' do
        @user.last_name_kana = 'ひらがな'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width characters.')
      end
      it 'last_name_kanaは半角カタカナでは登録できない' do
        @user.last_name_kana = 'ｶﾀｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width characters.')
      end

      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaは英字では登録できない' do
        @user.first_name_kana = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width characters.')
      end
      it 'first_name_kanaは数字では登録できない' do
        @user.first_name_kana = '1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width characters.')
      end
      it 'first_name_kanaは漢字では登録できない' do
        @user.first_name_kana = '漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width characters.')
      end
      it 'first_name_kanaはひらがなでは登録できない' do
        @user.first_name_kana = 'ひらがな'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width characters.')
      end
      it 'first_name_kanaは半角カタカナでは登録できない' do
        @user.first_name_kana = 'ｶﾀｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width characters.')
      end

      it '生年月日の値が空だと登録できない' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
