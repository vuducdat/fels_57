class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words, dependent: :destroy

  accepts_nested_attributes_for :lesson_words, reject_if:
    lambda {|attributes| attributes["content"].blank?}

  before_save :add_word

  private
  def add_word
    self.words = category.words.random(user)
  end

end
