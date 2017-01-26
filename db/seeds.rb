require 'faker'

roles = %w(premium standard)

5.times do
  user = User.new(
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(7),
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
    title: Faker::LordOfTheRings.character,
    body:  Faker::ChuckNorris.fact,
    private: false
  )
end

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
