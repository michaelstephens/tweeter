# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :string
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true
  validates :user_id, presence: true

  def to_s
    content
  end

  def self.search(search)
    if search
      where("lower(content) LIKE ?", "%#{search.downcase}%")
    else
      self.all
    end
  end
end
