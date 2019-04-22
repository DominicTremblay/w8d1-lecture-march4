require 'rails_helper'

RSpec.describe User, type: :model do

  # fixtures(:users)
  let(:user){build(:user)}
  let(:user2) {build(:user)}

  it 'is valid with the proper attributes' do 
   
    expect(user).to be_valid
  end


  it { should validate_presence_of(:name) }

  # context "when not providing the name" do

  #   it 'is not valid without a name' do
  #     user.name = nil
  #     expect(user).to_not be_valid
  #   end

  #   it 'reports a validation error on the name' do
  #     user.name = nil
  #     user.valid?
  #     expect(user.errors.full_messages).to include('Name can\'t be blank')
  #   end
  # end


  context "when validating email" do 

    it 'is not valid with an incorrect email' do
      user.email = '123@'
      user.valid?
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include('Email is invalid')
    end

    it 'is not valid with a duplicate email' do
      user.save
      user2.valid?
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages).to include("Email has already been taken")

    end

  end


end
