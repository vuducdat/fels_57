# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create! name: "admin", email: "adminzzz@gmail.com",
      password: "admin123", password_confirmation: "admin123", role: 1

20.times do |i|
  name = Faker::Name.name
  email = "sample-#{i+1}@gmail.com"
  password = "password"
  role = 0
  User.create! name: name, email: email, password: password, password_confirmation: password, role: role
end