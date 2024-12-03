require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "render a list of products" do
    get products_path

    assert_response :success
    assert_select ".product", 2
  end

  test "render a detailed product page" do
    get product_path(products(:iphone))

    assert_response :success
    assert_select ".title", "Iphone"
    assert_select ".description", "Iphone 15 pro max"
    assert_select ".price", "$ 1500"
  end

  test "render a new product form" do
    get new_product_path

    assert_response :success
    assert_select "form"
  end
end
