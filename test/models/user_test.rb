require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Should work" do
    user = User.create(name: "A1",  facebook_name: "A1", password: "123456",
                password_confirmation: "123456", facebook_id: "A1", email: "A1@gmail.com")
    assert user.valid?, "user have valid information"
  end

  def test_user_min_information
    user = User.create(facebook_name: "B1",  facebook_id: "B123456", email: "abc@gmail.com", password: "cannot be blank")
    assert user.valid?,  "user have valid information"
  end


end
