FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) + '9z' }
    password_confirmation { password }
    last_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
    last_name_kana { Gimei.last.katakana }
    first_name_kana { Gimei.first.katakana }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
