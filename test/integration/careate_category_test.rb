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
end
