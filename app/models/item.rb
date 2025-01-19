class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_date_estimate
  belongs_to :shipping_fee_burden
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40, message: 'is invalid' }
    validates :description, length: { maximum: 1000, message: 'is invalid' }
    validates :user_id
    with_options numericality: { other_than: 0, message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :shipping_fee_burden_id
      validates :prefecture_id
      validates :shipping_date_estimate_id
    end
  end
  validates :price, presence: true
  validates :price,
            numericality: { allow_blank: true, only_integer: true, greater_than_or_equal_to: 300,
                            less_than_or_equal_to: 9_999_999 }
end
