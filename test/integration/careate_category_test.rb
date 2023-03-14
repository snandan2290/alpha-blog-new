require "test_helper"

class CareateCategoryTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = User.create(username: "Vnandna", email: "Vnandan@gmail.com", password: "Vnandan", admin: true)
  end

  test "get new category form and create a category" do
    sign_in_as(@admin_user)
    get "/categories/new" 
    assert_response  :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: "Tech Blog"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Tech Blog", response.body
  end

  test "get new category form and reject invalid category submission" do
    sign_in_as(@admin_user)    
    get "/categories/new" 
    assert_response  :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: " "}}
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "h2.alert-heading"

  end  

end
