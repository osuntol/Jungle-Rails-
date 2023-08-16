require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    it "must be created with not matching password and password confrimation" do
      user = User.new(
        email: 'john@doe.com',
        first_name: 'john',
        last_name: 'doe',
        password: 'johndoe',
        password_confirmation: 'johnoe'
      )
      expect(user.valid?).to be_falsey
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'must be created with matching password and password confrimation' do
      user = User.new(
            email: 'john@doe.com',
            first_name: 'john',
            last_name: 'doe',
            password: 'johndoe',
            password_confirmation: 'johndoe'
          )
      expect(user.valid?).to be_truthy 
    end

    it 'emails must be unique (not case sensitive) is in the database' do
      user = User.new(
            email: 'john@doe.COM',
            first_name: 'john',
            last_name: 'doe',
            password: 'johndoe',
            password_confirmation: 'johndoe'
      )
      user2 = User.new(
            email: 'john@DOE.COM',
            first_name: 'john',
            last_name: 'doe',
            password: 'johndoe',
            password_confirmation: 'johndoe'
            )

      user.save
      user2.save
      expect(user2).to_not be_valid

    end


    it 'email, first name, last name should be required' do
      user = User.new(
        password: 'johndoe',
        password_confirmation: 'johndoe'
      )

      expect(user.valid?).to be_falsey

    end

    it 'Password length' do
      user = User.new(
        email: 'john@DOE.COM',
        first_name: 'john',
        last_name: 'doe',
        password: 'john',
        password_confirmation: 'john'
      )

      expect(user.valid?).to be_falsey
    end

  end 

  describe ".authentications " do
    it 'authenticates with email containing spaces' do
      user = User.create!(
        email: 'example@domain.com',
        first_name: 'john',
        last_name: 'doe',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials(' example@domain.com ', 'password')
      expect(authenticated_user).to eq(user)
    end
    
    it 'authenticates with email in different case' do
      user = User.create!(
        email: 'example@domain.com',
        first_name: 'john',
        last_name: 'doe',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end

