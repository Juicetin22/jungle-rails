require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should successfully save all required fields are submitted' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      
      @user.save

      puts "------------user test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"

      expect(@user.save).to be true
      expect(@user.errors.messages.length).to be 0
    end

  
  end
end
