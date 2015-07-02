user = User.create! name: "Legendme",
  email: "bka.dat@gmail.com",
  password: "123456",
  password_confirmation: "123456"

99.times do |n|
  target = User.create! name: FFaker::Name.name,
    email: FFaker::Internet.email,
    password: "123456",
    password_confirmation: "123456"
  user.follow target
  user.unfollow target if n.odd?
end

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

target = user.following.first
  4.times do |n|
  learner = n > 2 ? target : user
  category = Category.order("RANDOM()").first
  lesson = learner.lessons.create! category_id: category.id
  lesson.lesson_words.each do |r|
    r.answer = r.word.answers.order("RANDOM()").first
    r.save!
  end
  lesson.save!
end
