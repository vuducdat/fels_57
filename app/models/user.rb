class User < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships,  class_name:  "Relationship",
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
    foreign_key: "followed_id",
    dependent: :destroy                                
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save {self.email = email.downcase}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false} 
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
end
