require 'faker'

FactoryGirl.define do
  pw = Faker::Cat.name
  factory :user do
    sequence(:email) { |n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :member
    confirmed_at Time.now
  end
end
