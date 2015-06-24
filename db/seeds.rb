User.create!(name: "Legendme",
  email: "bka.dat@gmail.com",
  password: "123456",
  password_confirmation: "123456")

99.times do |n|
  name = Faker::Name.name
  email = "bka.dat-#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
