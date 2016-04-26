# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  content    :string
#  tags       :string
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Blog < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true

  def self.all_tags
    all.map{|b| b.tags.gsub(' ', '').split(',')}.flatten.compact.uniq
  end

  def self.filter(filter_word)
    if filter_word
      where("lower(tags) LIKE ?", "%#{filter_word.downcase}%")
    else
      self.all
    end
  end

end
