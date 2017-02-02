require 'faker'

FactoryGirl.define do
  pw = Faker::Lorem.characters(6)
  factory :user do
    sequence(:email) { |n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :member
    confirmed_at Time.now
  end
end
