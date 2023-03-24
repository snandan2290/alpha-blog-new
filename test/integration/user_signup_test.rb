require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest

  setup do
    @category = Category.create(name: "Travel")
    @category2 = Category.create(name: "Tech Blog")
  end

  test "Should sign up for a user" do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {username: "vidyanandan2290", email: "vidyanandan2290@gmail.com", password: "vidyanandan2290"}}
      assert_response :redirect      
    end
    follow_redirect!
    assert_response :success
    assert_match "vidyanandan22", response.body
  end

end
