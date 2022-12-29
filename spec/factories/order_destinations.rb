FactoryBot.define do
  factory :order_destination do
    post_code       { "#{Faker::Number.decimal_part(digits: 3)}-#{Faker::Number.decimal_part(digits: 4)}" }
    prefecture_id   { Faker::Number.between(from: 2, to: 48) }
    city            { Faker::Address.city }
    block           { Faker::Address.street_address }
    building_name   { Faker::Address.street_address }
    phone_no        { "0#{Faker::Number.decimal_part(digits: 10)}" }
    token           { 'tok_abcdefghijk00000000000000000' }
  end
end
