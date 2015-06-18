# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.create! name: "admin", email: "adminzzz@gmail.com",
#      password: "admin123", password_confirmation: "admin123", role: 1

10.times do |i|
  name = Faker::Name.name
  description = "Say somthings-#{i+1}, talk to me"
  Category.create! name: name, description: description
end