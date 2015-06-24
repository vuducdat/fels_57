class User < ActiveRecord::Base
  attr_accessor :remember_token
  
  has_many :following, through: :active_relationships, source: :followed
  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id",
    dependent: :destroy                                
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save {self.email = email.downcase}
  
  scope :normal, ->{where role: Settings.normal}
  scope :is_admins, ->{where role: Settings.admin}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: Settings.name_maximum}
  validates :email, presence: true, length: {maximum: Settings.email_maximum},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false} 
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.password_maximum_length},
    allow_nil: true

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated? remember_token
    return false if remember_digest.nil? 
    BCrypt::Password.new remember_digest.is_password? remember_token
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user 
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user 
    following.include? other_user 
  end
end
