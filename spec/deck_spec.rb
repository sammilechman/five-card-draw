require 'spec_helper'

describe Deck do

  subject(:deck) { Deck.new }

  describe '#generate_deck' do

    it 'should contain a set of 52 cards' do
      expect(deck.card_list.length).to eq(52)
    end

    it 'should have no repeat cards' do
      expect(deck.card_list.uniq.length).to eq(52)
    end

  end

  describe '#shuffle' do

    it "should have cards in different positions after" do
      first_three_cards = deck.card_list.first(3)
      deck.shuffle
      expect(deck.card_list.first(3)).to_not eq(first_three_cards)
    end
  end

  describe '#draw_cards' do

    it 'should return correct cards from the deck' do
      expected_cards = deck.card_list.last(4).reverse
      expect(deck.draw_cards(4)).to eq(expected_cards)
    end

  end

end