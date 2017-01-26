require 'faker'

FactoryGirl.define do
  factory :wiki do
    title Faker::Hipster.sentence
    body Faker::Hipster.paragraph
    user
  end
end
