class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :lesson_words
  has_many :lessons, through: :lesson_words

  accepts_nested_attributes_for :answers, allow_destroy: true,
   reject_if: lambda {|attributes| attributes["content"].blank?}

  validates :content, presence: true  

  query = "id not in (select lw.word_id from lesson_words as lw) AND category_id == ?"

  scope :in_category, ->category_id{where category_id: category_id}
  scope :random, ->(user_id){Word.not_learned_by_user(user_id).limit(Settings.words_per_lesson).order("RANDOM()")}
  scope :not_learned_by_user, ->(user_id){includes(:lessons)
    .where("lessons.user_id != ? OR lessons.user_id IS NULL", user_id)
    .references(:lessons)}
  scope :learned_by_user_id_in_category, ->(user_id, category_id){joins(:lessons)
    .where "lessons.user_id == ? AND words.category_id == ?", user_id, category_id}

end
