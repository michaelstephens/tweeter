# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true

  def to_s
    content
  end
end
