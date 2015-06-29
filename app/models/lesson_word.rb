class LessonWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer

  def is_correct?
    answer.is_correct?
  end
end
