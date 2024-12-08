require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "render a list of categories" do
    get categories_path

    assert_response :success
    assert_select ".category", 10
  end

  test "create a new category" do
    post categories_path, params: { category: { name: "comics" } }

    assert_redirected_to categories_path
    assert_equal flash[:notice], "Your category was created"
  end

  test "edit a category" do
    patch category_path(categories(:technology)), params: { category: { name: "tech" } }

    assert_redirected_to categories_path
    assert_equal flash[:notice], "Your category was updated"
  end
end
