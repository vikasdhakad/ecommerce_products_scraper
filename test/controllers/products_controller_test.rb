require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should create product" do
    category = Category.create(name: "Sports")
    product = Product.create(
      title: "Sports/Regular Cap (Pack of 3)",
      description: "Product Details\nFabric\nCOTON\nColor\nBlack\nStyle code\nCOMBO PACK OF 3\nOccasion\nCasual, Formal, Lounge Wear, Party, Sports\nNet Quantity\n3\nManufacturing, Packaging and Import Info",
      price: 345,
      contact_info: "BackToBackSale",
      size: "Free",
      category_id: category.id,
      url: "https://www.flipkart.com/flexcy-sports-regular-cap/p/itmec8c2807a266b",
      image_url: "https://rukminim2.flixcart.com/image/832/832/kynb6vk0/cap/g/z/m/free-combo-pack-of-3-flexcy-original-imagauaxe7sfepmn.jpeg?q=70&crop=false",
      last_scraped_at: Time.zone.now
    )
    
    assert_not product.persisted?, "Product was saved."
  end

  test "should not create product with missing title" do
    category = Category.create(name: "Electronics")
    product = Product.create(
      description: "Sample description",
      price: 100,
      contact_info: "Sample contact",
      size: "M",
      category_id: category.id
    )
    
    assert_not product.persisted?, "Product was saved without a title"
    assert_includes product.errors[:title], "can't be blank"
  end

  test "should not create product with negative price" do
    product = Product.create(
      title: "Sample Product",
      description: "Sample description",
      price: -50,
      contact_info: "Sample contact",
      size: "M",
      category_id: 1
    )
    
    assert_not product.persisted?, "Product was saved with a negative price"
    assert_includes product.errors[:price], "must be greater than or equal to 0"
  end

  test "should create product with valid attributes" do
    product = Product.create(
      title: "Valid Product",
      description: "Valid description",
      price: 100,
      contact_info: "Valid contact",
      size: "L",
      category_id: 2,
      image_url: "http://example.com/image.jpg",
      last_scraped_at: Time.zone.now,
      created_at: Time.zone.now
    )
    
    assert product.persisted?, "Product was not saved with valid attributes"
  end

  test "should update product details" do
    product = products(:one)

    product.update(description: "Updated description")
    
    assert_equal "Updated description", product.reload.description, "Product description was not updated"
  end

  test "should not create product with invalid image URL" do
    product = Product.create(
      title: "Product with Invalid Image URL",
      description: "Sample description",
      price: 50,
      contact_info: "Sample contact",
      size: "S",
      category_id: 1,
      image_url: "invalid_url",
      last_scraped_at: Time.zone.now,
      created_at: Time.zone.now
    )
    
    assert_not product.persisted?, "Product was saved with an invalid image URL"
    assert_includes product.errors[:image_url], "is not a valid URL"
  end

  test "should update product category" do
    category1 = Category.create(name: "Furniture")
    category2 = Category.create(name: "Home Decor")
    product = Product.create(
      title: "Wooden Chair",
      description: "Comfortable wooden chair",
      price: 50,
      contact_info: "Furniture Store",
      size: "L",
      category_id: category1.id,
      image_url: "http://example.com/wooden-chair.jpg",
      last_scraped_at: Time.zone.now,
      created_at: Time.zone.now
    )

    product.update(category_id: category2.id)

    assert_equal category2.id, product.category_id, "Product category was not updated correctly"
    assert_includes category2.products, product, "Category2 does not have the product"
  end
end
