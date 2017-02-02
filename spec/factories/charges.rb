FactoryGirl.define do
  factory :charge do
    user
    amount '9.99'
    successful false
  end
end
