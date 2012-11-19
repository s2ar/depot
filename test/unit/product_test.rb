require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures:products
  # test "the truth" do
  #   assert true
  # end
  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  test "product title must have minimum 10 chars or larger" do
    product = Product.new(price: 25, description: "yyy", image_url: "zzz.jpg")
    product.title = "Test title product"    
    assert product.valid?, I18n.t("errors.messages.too_short.other", :count => 10)

  end

  test "product price must be positive" do
	  # цена товара должна быть положительной
	  product = Product.new(title: "My book Title",	description: "yyy", image_url: "zzz.jpg")
	  product.price = -1
	  assert product.invalid?
	  assert_equal I18n.t("errors.messages.greater_than_or_equal_to", :count => 0.01), product.errors[:price].join("; ")
	  # должна быть больше или равна 0,01
	  product.price = 0
	  assert product.invalid?
	  assert_equal I18n.t("errors.messages.greater_than_or_equal_to", :count => 0.01), product.errors[:price].join("; ")
	  product.price = 1
	  assert product.valid?
  end

  def new_product(image_url)
  	Product.new(title: "My Book Title", 
  		description: "kjaksd", 
  		price:1, 
  		image_url:image_url)  	
  end

  test "image url" do
  	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://google.com/fred.gif }
  	bad = %w{ fred.doc fred.gif/more fred.gif.more }

  	ok.each do |name|
  		assert new_product(name).valid?, "#{name} should not be invalid"
  	end	  	
  	bad.each do |name|
  		assert !new_product(name).valid?, "#{name} should not be invalid"
  	end	

  end

   test "product is not valid without a unique title - i18n" do
   	product = Product.new(title: products(:ruby).title, 
   							description: "dsasd",
   							price: 1,
   							image_url:"fred.jpg")
   	assert !product.save
   	assert_equal I18n.t('activerecord.errors.messages.taken'),
   		product.errors[:title].join("; ")												
   end

end
