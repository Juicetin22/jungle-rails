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

    it 'should not save if email is not unique' do
      @testuser = User.create(first_name: "George", last_name: "Bob", email: "george@bob.com", password: "georgebob", password_confirmation: "georgebob")
      @testuser2 = User.create(first_name: "Jeorg", last_name: "Bog", email: "jeorg@bog.com", password: "jeorgbog", password_confirmation: "jeorgbog")
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = "george@boB.com"
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      
      @user.save

      puts "------------user test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"

      expect(@user.save).to be false
      # expect(@user.password == @user.password_confirmation).to be true
      
      list_of_emails = []
      User.all.each do |user|
        list_of_emails << user.email
      end
      expect(list_of_emails).not_to include @user.email
    end
  
    it 'should not save if first name field is empty' do
      @user = User.new
      @user.first_name = nil
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      
      @user.save

      puts "------------user test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"

      expect(@user.save).to be false
      expect(@user.errors.messages[:first_name]).to include "can't be blank"
    end
  end
end
