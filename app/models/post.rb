class Post < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true

  def to_s
    content
  end
end
