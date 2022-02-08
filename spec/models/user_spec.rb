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

      puts "------------succuess user test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"

      expect(@user.save).to be true
      expect(@user.errors.messages.length).to be 0
      expect(@user.password == @user.password_confirmation).to be true
    end

    
    it 'should not save if first name field is empty' do
      @user = User.new
      @user.first_name = nil
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      
      @user.save
      
      puts "------------user first_name test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"
      
      expect(@user.save).to be false
      expect(@user.errors.messages[:first_name]).to include "can't be blank"
    end
    
    it 'should not save if last name field is empty' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = nil
      @user.email = "moo@boo.com"
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      
      @user.save
      
      puts "------------user last_name test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"
      
      expect(@user.save).to be false
      expect(@user.errors.messages[:last_name]).to include "can't be blank"
    end
    
    it 'should not save if email field is empty' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = nil
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      
      @user.save
      
      puts "------------user email test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"
      
      expect(@user.save).to be false
      expect(@user.errors.messages[:email]).to include "can't be blank"
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

      puts "------------user unique_email test---------------"
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

    it 'should not save if password field is empty' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = nil
      @user.password_confirmation = "mooboo"
      
      @user.save

      puts "------------user password test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"

      expect(@user.save).to be false
      expect(@user.errors.messages[:password]).to include "can't be blank"
    end

    it 'should not save if password confirmation is not equal to password' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = "mooboo"
      @user.password_confirmation = "moobo"
      
      @user.save

      puts "------------user password_confirmation test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"

      expect(@user.save).to be false
      expect(@user.password == @user.password_confirmation).to be false
    end

    it 'should not save if password is less than 5 characters' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = "moob"
      @user.password_confirmation = "moob"
      
      @user.save

      puts "------------user password_confirmation test---------------"
      puts @user.errors.messages
      puts @user.errors.full_messages
      puts "---------------------------"

      expect(@user.save).to be false
      expect(@user.password.length).to be < 5
    end

    it 'should allow users to login in successfully even if there are spaces outside of email address' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      @user.save

      @login = User.authenticate_with_credentials("  moo@boo.com  ", "mooboo")
      expect(@login).not_to be nil
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should login a user if method finds a correct user and password' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      @user.save

      @login = User.authenticate_with_credentials("moo@boo.com", "mooboo")
      expect(@login).not_to be nil
    end

    it 'should return nil if email is not in the database' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      @user.save

      @login = User.authenticate_with_credentials("MOOSE@goose.com", "moosgoos")
      expect(@login).to be nil
    end

    it 'should return nil if password inputted is incorrect' do
      @user = User.new
      @user.first_name = "Moo"
      @user.last_name = "Boo"
      @user.email = "moo@boo.com"
      @user.password = "mooboo"
      @user.password_confirmation = "mooboo"
      @user.save

      @login = User.authenticate_with_credentials("moo@boo.com", "moosgoos")
      expect(@login).to be nil
    end
  end
end
