require 'spec_helper.rb'

describe Card do
  subject(:card) { Card.new(:ten, :hearts) }

  describe '#initialize' do

    it "should set the suit of the card" do
      expect(card.suit).to eq(:hearts)
    end

    it "should set the face of the card" do
      expect(card.face).to eq(:ten)
    end

  end

  describe '#value' do
    it "should return a value of 10 for a ten card" do
      expect(card.value).to eq(10)
    end

    it "should return a value of 14 for an ace card" do
      card = Card.new(:ace, :hearts)
      expect(card.value).to eq(14)
    end

  end


end