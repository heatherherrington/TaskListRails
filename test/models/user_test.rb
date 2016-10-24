require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Can create a user" do
    assert_difference('User.count', 1) do
      User.create(name: "Heather", email: "email@gmail.com", provider: "github", uid: 1352)
    end
  end

  test "Cannot create a user without an email address" do
    user = User.new(name: "Heather", provider: "github", uid: 1352)
    assert_no_difference('User.count') do
      user.save
    end
  end

  test "Cannot create a user without a provider" do
    user = User.new(name: "Heather", email: "email@gmail.com", uid: 1352)
    assert_no_difference('User.count') do
      user.save
    end
  end

  test "Cannot create a user with the same uid and provider" do
    user = users(:userone)
    user1 = User.new(name: "Heather", email: "email@gmail.com", provider: "github", uid: 12345)
    assert_no_difference('User.count') do
      user1.save
    end
  end
end
