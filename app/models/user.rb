class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :password, format: { allow_blank: true, with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'must contain both letters and numbers'}
  with_options presence: true do
    validates :nickname
    validates :last_name,
              format: { allow_blank: true, with: /\A[ぁ-んァ-ヶー-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :first_name,
              format: { allow_blank: true, with: /\A[ぁ-んァ-ヶー-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :last_name_kana,
              format: { allow_blank: true, with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :first_name_kana,
              format: { allow_blank: true, with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :birth_date
  end
end
