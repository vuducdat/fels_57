class Activity < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  scope :newest, ->{order(created_at: :desc)}

  Settings.activity_status.each do |state_key, state_value|
    define_method ("is_#{state_key}?") {target_type == state_value}
  end

  def target
    if is_learned?
      Lesson.find target_id
    else
      User.find target_id
    end
  end
end
