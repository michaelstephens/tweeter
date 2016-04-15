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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
