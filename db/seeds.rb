User.create! name: "Legendme",
  email: "bka.dat@gmail.com",
  password: "123456",
  password_confirmation: "123456"

99.times do |n|
  target = User.create! name: FFaker::Name.name,
    email: FFaker::Internet.email,
    password: "123456",
    password_confirmation: "123456"
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

5.times do |n|
  category = Category.create! name: FFaker::Lorem.word,
    description: FFaker::Lorem.sentence(4)
  20.times do |n|
    word = category.words.create! content: FFaker::Lorem.word
    word.answers.create! content: FFaker::Lorem.word, is_correct: true
   10.times do |n|
    word.answers.create! content: FFaker::Lorem.word, is_correct: false
  end
  end
end

4.times do |n|
  category = Category.first
  lesson = user.lessons.create! category_id: category.id, correct_number: 10
  words = category.words.take 20
  words.each do |word|
    answer = word.answers.order("RANDOM()").first
    lesson_words = lesson.lesson_words.create! answer_id: answer.id, word_id: word.id
    lesson.correct_number += 1 if answer.is_correct?
  end
  lesson.save!
  user.activities.create! target_id: lesson.id, target_type: Settings.activity_status.learned
end

user.activities.create! target_id: 1, target_type: Settings.activity_status.follow
user.activities.create! target_id: 2, target_type: Settings.activity_status.unfollow  
