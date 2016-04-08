class User < ActiveRecord::Base
  has_many :posts

  validates :email, presence: true, uniqueness: true
end
