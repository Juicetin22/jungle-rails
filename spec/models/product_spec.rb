require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should successfully save when all four required input fields are set' do
      @category = Category.create(name: "moomoo")
      @product = Product.new
      @product.name = "plop"
      @product.price = 22
      @product.quantity = 101
      @product.category_id = @category.id
      @product.save

      puts "---------------------------"
      puts @product.errors.messages
      puts "---------------------------"
      expect(@product.save).to be true
      # expect(@product.errors.messages[:category]).to include "can't be blank"
    end
  end
end
