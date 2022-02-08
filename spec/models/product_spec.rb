require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should successfully save when all four required input fields are set' do
      # create a category in database to use to test product
      @category = Category.create(name: "moomoo")
      @product = Product.new
      @product.name = "plop"
      @product.price = 22
      @product.quantity = 101
      @product.category_id = @category.id
      @product.save

      # error message object should be empty
      puts "---------------------------"
      puts @product.errors.messages
      puts "---------------------------"
      expect(@product.save).to be true
      # expect(@product.errors.messages[:category]).to include "can't be blank"
    end

    it 'should prevent saving the product info when the name is not present' do
      @category = Category.create(name: "moop")
      @product = Product.new
      @product.name = nil
      @product.price_cents = 222
      @product.quantity = 1010
      @product.category_id = @category.id
      @product.save

      puts "---------------------------"
      puts @product.errors.messages
      puts @product.errors.full_messages
      puts "---------------------------"
      expect(@product.save).to be false
      expect(@product.errors.messages[:name]).to include "can't be blank"
    end
  end
end
