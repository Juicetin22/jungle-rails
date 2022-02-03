class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: Rails.configuration.admin[:basic_auth_name], password: Rails.configuration.admin[:basic_auth_password]
  
  def show
    @number_of_products = Product.count(:id)
    @number_of_categories = Category.count(:id)
    @categories = Category.all
  end
end
