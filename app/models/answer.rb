class Answer < ActiveRecord::Base
  belongs_to :word

  has_many :lesson_words, dependent: :destroy
  has_many :lesson, through: :lesson_words

  validates :content, presence: true
end
