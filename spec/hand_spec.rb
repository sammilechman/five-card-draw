require 'spec_helper'
describe Hand do

  subject(:hand) { Hand.new }
  let(:deck) {Deck.new}

  describe '#draw_initial_hand' do
    it "should draw five cards from the deck to form initial hand" do
      hand.draw_initial_hand(deck)
      expect(hand.set.count).to eq(5)
    end
  end

  describe '#get_cards' do
    it "should draw cards from a deck" do
      hand.get_cards(deck, 5)
      expect(hand.set.count).to eq(5)
    end

    it 'should have eight cards after an initial hand and draw three' do
      hand.draw_initial_hand(deck)
      hand.get_cards(deck, 3)
      expect(hand.set.count).to eq(8)
    end
  end

  describe '#discard' do
    before(:each) { hand.draw_initial_hand(deck) }


    it 'should remove one card from the set' do
      second_card = hand.set[1]
      hand.discard(1)
      expect(hand.set.include?(second_card)).to eq(false)

    end

    it 'should remove three cards from the set do' do
      second_card = hand.set[1]
      third_card = hand.set[2]
      fifth_card = hand.set[4]
      hand.discard(1, 4, 2)
      expect(hand.set.include?(second_card)).to eq(false)
      expect(hand.set.include?(third_card)).to eq(false)
      expect(hand.set.include?(fifth_card)).to eq(false)

    end


  end
end