require 'random_data'

roles = %w(premium standard)

5.times do
  user = User.new(
    email:    RandomData.random_email,
    password: RandomData.random_sentence,
    role: roles.sample
  )
  user.skip_confirmation!
  user.save!
end

premium = User.new(
  email: 'premium@example.com',
  password: 'password',
  role: 'premium'
)
premium.skip_confirmation!
premium.save!

admin = User.new(
  email:    'admin@example.com',
  password: 'password',
  role:     'admin'
)
admin.skip_confirmation!
admin.save!

users = User.all

50.times do
  Wiki.create!(
    user: users.sample,
    title: RandomData.random_sentence,
    body:  RandomData.random_paragraph,
    private: false
  )
end

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
