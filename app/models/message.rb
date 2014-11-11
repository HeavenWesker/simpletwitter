class Message < ActiveRecord::Base
  attr_accessible :content, :to_id, :user_id
  belongs_to :user, dependent: :destroy
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  default_scope order: 'messages.created_at DESC'
  before_save :insert_to_id
  def insert_to_id
    /\Ad @(\w+)\s([\s\S]+)/.match(self[:content]) do |match|
      self[:to_id] = User.find_by_id_name(match[1]).id
    end
  end
  def self.from_self_or_to_me(user)
    where("(user_id = :user_id) OR (to_id = :to_id)", user_id: user.id, to_id: user.id)
  end
end
