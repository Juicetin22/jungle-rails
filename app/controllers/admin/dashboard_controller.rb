class Admin::DashboardController < ApplicationController
  def show
    @number_of_products = Product.count(:id)
    @number_of_categories = Category.count(:id)
  end
end
