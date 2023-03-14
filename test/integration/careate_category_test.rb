require "test_helper"

class CareateCategoryTest < ActionDispatch::IntegrationTest

  test "get new category form and create a category" do
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
