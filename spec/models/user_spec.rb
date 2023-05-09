require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    before(:each) do
      @user = User.new(
        email: 'test@test.com',
        first_name: 'Test',
        last_name: 'User',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    describe 'password validation' do
      it 'is not valid without a password' do
        @user.password = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'is not valid without a password confirmation' do
        @user.password_confirmation = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it 'is not valid when password and password_confirmation do not match' do
        @user.password_confirmation = 'different_password'
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      describe 'password is less than 4 characters' do
        it 'should be minimum of 4 characters' do
          @user.password = nil
          expect(@user).not_to be_valid
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 4 characters)')
        end
      end
    end

    describe 'email validation' do
      it 'is not valid without an email' do
        @user.email = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'is not valid with a duplicate email (case-insensitive)' do
        @user2 = User.new(
          email: 'TEST@TEST.com',
          first_name: 'Test',
          last_name: 'User',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(@user2).to_not be_valid
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
    end

    describe 'first name validation' do
      it 'is not valid without a first name' do
        @user.first_name = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
    end

    describe 'last name validation' do
      it 'is not valid without a last name' do
        @user.last_name = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
    end
  end

  # Test cases for authenticate_with_credentials method
  describe '.authenticate_with_credentials' do

    it 'returns user instance if authentication succeeds' do
      user = User.create(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user.email).to eq(user.email)
      expect(authenticated_user.first_name).to eq(user.first_name)
      expect(authenticated_user.last_name).to eq(user.last_name)
    end

    it 'returns nil if authentication fails due to incorrect password' do
      user = User.create(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil if authentication fails due to incorrect email' do
      user = User.create(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('wrongemail@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'returns user instance if authentication succeeds with extra whitespace around email address' do
      user = User.create(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user.email).to eq(user.email)
      expect(authenticated_user.first_name).to eq(user.first_name)
      expect(authenticated_user.last_name).to eq(user.last_name)
    end

    it 'returns user instance if authentication succeeds with email address in wrong case' do
      user = User.create(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('tEsT@eXaMpLe.cOm', 'password')
      expect(authenticated_user.email).to eq(user.email)
      expect(authenticated_user.first_name).to eq(user.first_name)
      expect(authenticated_user.last_name).to eq(user.last_name)
    end
  end
end
