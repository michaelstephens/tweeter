# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  created_at       :datetime
#  updated_at       :datetime
#  username         :string
#  first_name       :string
#  last_name        :string
#  crypted_password :string
#  salt             :string
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def name
    "#{first_name} #{last_name}".titleize
  end

  def self.search(search)
    if search
      where("lower(email) LIKE ? OR lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(username) LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%")
    else
      self.all
    end
  end
end
