FactoryBot.define do
  factory :order_address do
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Gimei.city.to_s }
    house_number { "#{Gimei.town} #{Faker::Number.between(from: 1, to: 99)}-#{Faker::Number.between(from: 1, to: 99)}" }
    building_name { Gimei.town.to_s }
    array = [9, 10]
    phone_number { "0#{Faker::Number.number(digits: array[rand(2)])}" }
    token { "tok_#{Faker::Alphanumeric.alphanumeric(number: 24)}" }
  end
end
