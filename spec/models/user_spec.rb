require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = User.new(name: "test name", email: 'email@gmail.com', password: 'asdasdasd', password_confirmation: 'asdasdasd')
  end

  describe 'Validations' do 
    it "should not let user be created without a password" do
      @user.password = nil
      @user.password_confirmation = nil
      @user.save
      expect(@user).not_to be_valid
    end
    it "should not let user be created without a password_confirmation" do
      @user.password_confirmation = nil
      @user.save
      expect(@user).not_to be_valid
    end
    it "should not let user be created without an email" do
      @user.email = nil
      @user.save
      expect(@user).not_to be_valid
    end
    it "should not let user be created without a name" do
      @user.name = nil
      @user.save
      expect(@user).not_to be_valid
    end
    it "should not let user be created without unique email" do
      @user.save
      @user2 = User.create(name: "test name", email: 'email@gmail.com', password: 'asdasdasd', password_confirmation: 'asdasdasd')
      expect(@user2).not_to be_valid
    end
    it "should not let user be created when the email already exists in lower case" do
      @user.save
      @user2 = User.create(name: "test name", email: 'EMAIL@GMAIL.COM', password: 'asdasdasd')
      expect(@user2).not_to be_valid
    end
    it "should let user be created when the password length is less than 6" do
      @user.password = '123'
      expect(@user).not_to be_valid
    end
    it 'should have matching password and password confirmation' do 
      @user.password_confirmation = '12345'
      expect(@user.password).not_to be_equal(@user.password_confirmation)
      expect(@user).not_to be_valid
    end
  end
  describe '.authenticate_with_credentials' do
    it 'should authenticate if password and email are valid' do
      user = User.create(name: 'an khor', email: 'ankhor@email.com', password: 'apples', password_confirmation: 'apples')
      valid_user = User.authenticate_with_credentials('ankhor@email.com', 'apples')
  
      expect(valid_user).to eq(user)
      end
  
      it 'should not authenticate if email does not exist' do
        user = User.create(name: 'an khor', email: 'ankhor@email.com', password: 'apples', password_confirmation: 'apples')
        invalid_user = User.authenticate_with_credentials('notemail@notemail.com', 'apples')
    
        expect(invalid_user).to_not eq(user)
      end
      it 'should not authenticate if email does not exist' do
        user = User.create(name: 'an khor', email: 'ankhor@email.com', password: 'apples', password_confirmation: 'apples')
        invalid_user = User.authenticate_with_credentials('ankhor@email.com', 'oranges')
        expect(invalid_user).to_not eq(user)
      end
  
      it 'should authenticate if user adds uppercase letters to their email' do
        user = User.create(name: 'an khor', email: 'email@email.com', password: 'apples', password_confirmation: 'apples')
        valid_user = User.authenticate_with_credentials('EMAIL@email.com', 'apples')
        expect(valid_user).to eq(user)
      end
  
      it 'should authenticate if user adds spaces to beginning or end of email' do
        user = User.create(name: 'an Khor', email: 'email@email.com', password: 'oranges', password_confirmation: 'oranges')
        valid_user = User.authenticate_with_credentials(' email@email.com ', 'oranges')
        expect(valid_user).to eq(user)
      end
  end
end
