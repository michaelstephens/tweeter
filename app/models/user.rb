class User < ActiveRecord::Base
  has_many :posts

  validates :email, presence: true, uniqueness: true

  def to_s
    email
  end
end
