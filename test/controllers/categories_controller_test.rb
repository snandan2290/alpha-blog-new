require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  setup do
    puts "Testing setup"
    @category = Category.create(name: "sports")
    @admin_user = User.create(username: "Vnandna", email: "Vnandan@gmail.com", password: "Vnandan", admin: true)
    
  end

  test "should get index" do
    # begin    
    #   category = Category.create(name: "Sports-1")
      puts "@category::should get index::#{@category.id}"
      get categories_url
      assert_response :success
    # ensure
    #   ActiveRecord::Base.connection_pool.release_connection      
    # end      
  end

  test "should get new" do
    # begin    
    #   category = Category.create(name: "Sports-1")
      sign_in_as(@admin_user)
      puts "@category::should get new:::#{@category.id}"
      get new_category_url
      assert_response :success
    # ensure
    #   ActiveRecord::Base.connection_pool.release_connection      
    # end      
  end

  test "should create category" do
    sign_in_as(@admin_user)    
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: {name: 'Travel' } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should not create category if not admin" do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: {name: 'Travel' } }
    end

    assert_redirected_to categories_url
  end

  test "should show category" do
    # category = Category.create(name: "Sports-2")
    puts "@category::should show category:::#{@category.id}"
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end