class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true, length: { minimum: 5 }

  def self.authenticate_with_credentials(email, password)
    # account for whitespace and character casing
    modified_email = email.strip.downcase
    @user = User.find_by_email(modified_email)
    # if user exists AND the password entered is correct, return @user to session controller
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
  
end
