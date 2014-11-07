class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :id_name
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", 
    class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  validates :name,  presence: true,   length:   { minimum:5, maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,   
    length:       { minimum:5, maximum: 50 },   
    format:       { with: VALID_EMAIL_REGEX },  
    uniqueness:   { case_sensitive: false }
  before_save { self.email.downcase! }
  before_save :create_remember_token
  validates :password,              length:   { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :id_name,               presence: true, length: { minimum: 1, maximum: 30 }
  def feed
    Micropost.from_users_followed_by_or_reply(self)
  end
  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end
  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end
  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end
  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
