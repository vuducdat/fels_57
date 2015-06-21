# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.all
categories.each do |category|
  20.times do |n|
    word_content = "Hello #{category.id}.#{n+1}"
    category.words.create! content:  word_content
  end
end

words = Word.all
words.each do |word|
  correct = 1 + Random.rand(4)
  4.times do |n|
    answer_content = "Answer #{word.category_id}.#{word.id}.#{n+1}"
    if n == correct
      word.answers.create! content: answer_content, is_correct: true
    else
      word.answers.create! content: answer_content, is_correct: false
    end
  end
end
