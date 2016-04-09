class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :content, presence: true
  validates :user_id, presence: true

  def to_s
    content
  end
end
