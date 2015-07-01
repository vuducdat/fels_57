class Activity < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  query = "SELECT user_id FROM users INNER JOIN relationships ON
    users.id = relationships.followed_id"

  scope :newest, ->{order(created_at: :desc)}
  scope :followed, ->(user){where("user_id IN (?) OR user_id = ?",
    query, user.id).order created_at: :desc}

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
