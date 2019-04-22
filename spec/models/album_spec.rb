require 'rails_helper'

RSpec.describe Album, type: :model do

    let (:title) {'Divide'}
    let (:year) {2017}
    let (:album) {Album.new title: title, year: year}


  context 'when all the fields are valid' do

    it 'is valid with the proper attributes' do
      expect(album).to be_valid
    end

    it 'is not reporting validation error' do
      album.valid?
      expect(album.errors.full_messages).to be_empty
    end

  end

  context "when title is not provided" do

    let (:title){nil}

    it 'is not valid without a title' do
      expect(album).to_not  be_valid
    end

    it 'reports a validation error on the title' do
      album.valid?
      expect(album.errors.full_messages).to include("Title can't be blank")
    end

  end

  context "when year is not provided" do

    let (:year) {nil}

    it 'is not valid without a year' do
      expect(album).to_not be_valid
    end

    it 'reports a validation error on the year' do
      album.valid?
      expect(album.errors.full_messages).to include("Year can't be blank")
    end

  end




end
