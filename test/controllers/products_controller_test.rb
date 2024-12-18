require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
  end

  test "render a list of products" do
    get products_path

    assert_response :success
    assert_select ".product", 12
  end

  test "render a detailed product page" do
    get product_path(products(:iphone))

    assert_response :success
    assert_select ".title", "iPhone 13"
    assert_select ".description", "Funciona correctamente."
    assert_select ".price", "$ 400"
  end

  test "render a new product form" do
    get new_product_path

    assert_response :success
    assert_select "form"
  end

  test "allow to create a new product" do
    post products_path, params: {
      product: {
        title: "Xiaomi",
        description: "Poco X3 pro",
        price: 250,
        stock: 2,
        category_id: categories(:technology).id
      }
    }

    assert_redirected_to product_path(Product.last.id)
    assert_equal flash[:notice], "Your product was created"
  end

  test "does not allow to create a new product with empty fields" do
    post products_path, params: {
      product: {
        title: "",
        description: "Poco X3 pro",
        price: 250,
        stock: 2
      }
    }

    assert_response :unprocessable_entity
  end

  test "render an edit product form" do
    get edit_product_path(products(:iphone))

    assert_response :success
    assert_select "form"
  end

  test "allow to update a product" do
    patch product_path(products(:iphone)), params: {
      product: {
        stock: 4
      }
    }

    assert_redirected_to product_path(products(:iphone))
    assert_equal flash[:notice], "Your product was updated"
  end

  test "can delete products" do
    assert_difference("Product.count", -1) do
      delete product_path(products(:iphone))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], "Your product was deleted"
  end
end
