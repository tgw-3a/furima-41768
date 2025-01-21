class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :order_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :order_id
    validates :postal_code, format: { allow_blank: true, with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :house_number
    validates :phone_number, numericality: { allow_blank: true, only_integer: true }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, phone_number: phone_number,
                   building_name: building_name, order_id: order.id)
  end
end
