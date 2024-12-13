require "test_helper"

class CategoryControllerTest < ActionDispatch::IntegrationTest
  test "should create category" do
    category = Category.new(name: "Electronics")
    assert category.save, "Category was not saved"
  end

  test "should not create category without name" do
    category = Category.new(name: nil)
    assert_not category.save, "Category saved without a name"
    assert_not_empty category.errors[:name], "Name can't be blank"
  end

  test "should not create category with duplicate name" do
    Category.create(name: "Electronics")
    duplicate_category = Category.new(name: "Electronics")
    assert_not duplicate_category.save, "Duplicate category name was allowed"
    assert_not_empty duplicate_category.errors[:name], "Name has already been taken"
  end

  test "should have many products" do
    category = Category.create(name: "Home Appliances")
    product1 = Product.create(title: "Washing Machine", description: "High-efficiency washing machine", price: 500, category: category)
    product2 = Product.create(title: "Refrigerator", description: "Energy-saving refrigerator", price: 700, category: category)

    # Ensure the category has the correct number of products
    assert_equal 2, category.products.count, "Category doesn't have the correct number of products"
  end

  test "should associate product with category" do
    category = Category.create(name: "Tech")
    product = Product.create(title: "Smartphone", description: "Latest model", price: 999, category: category)

    # Ensure the product is correctly associated with the category
    assert_equal category.id, product.category_id, "Product is not correctly associated with the category"
  end

  test "category name should be valid" do
    category = Category.new(name: "Valid Category")
    assert category.valid?, "Category name is valid"
    
    category.name = " "
    assert_not category.valid?, "Category with blank name should not be valid"
    
    category.name = "Tech"
    assert category.valid?, "Category name 'Tech' should be valid"
  end

  test "should delete category" do
    category = Category.create(name: "Fashion")
    category_id = category.id
    
    # Delete the category and ensure it was deleted
    category.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Category.find(category_id) }
  end
end
