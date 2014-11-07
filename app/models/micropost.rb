class Micropost < ActiveRecord::Base
  attr_accessible :content, :in_reply_to
  belongs_to :user
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }, presence: true
  default_scope order: 'microposts.created_at DESC'
  def self.from_users_followed_by_or_reply(user)
    followed_user_ids = "select followed_id from relationships where follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR 
          user_id = :user_id OR
          in_reply_to = :user_id_name ",
          user_id: user.id, user_id_name: user.id_name)
  end
end
