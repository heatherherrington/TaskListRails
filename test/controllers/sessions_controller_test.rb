require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create, { provider: "github" }
  end

  test "can create a user" do
    assert_difference('User.count', 1) do
      login_a_user
      assert_response :redirect
      assert_redirected_to :tasks
      assert_not_nil session[:user_id]
    end
  end

  test "Logging in twice should not create two users" do
    assert_difference('User.count', 1) do
      login_a_user
    end

    assert_no_difference('User.count') do
      login_a_user
      assert_response :redirect
      assert_redirected_to :tasks
      assert_not_nil session[:user_id]
    end
  end

  test "Attempting to login without email shouldn't work" do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    request.env['omniauth.auth'][:info].delete(:email)

    assert_no_difference("User.count") do
      get :create, { provider: "github" }
    end
  end
end
