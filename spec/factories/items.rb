FactoryBot.define do
  factory :item do
    name { Faker::Game.title[1, 40] }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    description { Faker::Lorem.sentence[1, 400] }
    category_id { Faker::Number.between(from: 1, to: 10) }
    condition_id { Faker::Number.between(from: 1, to: 6) }
    shipping_fee_burden_id { Faker::Number.between(from: 1, to: 2) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    shipping_date_estimate_id { Faker::Number.between(from: 1, to: 3) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
