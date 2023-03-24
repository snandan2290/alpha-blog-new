require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "Vnandan", email: "Vnandan@gmail.com", password: "Vnandan", admin: true)
    @category_ids = Category.all.ids[0..1]
  end

  test "Should create a new article" do
    sign_in_as(@user)
    get '/articles/new'
    assert_response :success
    assert_difference 'Article.count',1 do
      post articles_path, params: { article: {title: "A new test check", 
        description: "Article cerated to check integration testShould create a new article",
        category_ids: @category_ids
        }
      }
    assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "A new test check", response.body
  end

end