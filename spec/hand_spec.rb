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

  describe '#flush' do
    it "should return [handtype, relavent] if hand is a flush" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:eight, :hearts),
        Card.new(:eight, :hearts), Card.new(:two, :hearts),
        Card.new(:six, :hearts)])
        hand.sort_set!
        expect(hand.flush).to eq([:flush, :ten])
    end

    it "should return false if not a flush" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:eight, :clubs),
        Card.new(:eight, :hearts), Card.new(:two, :hearts),
        Card.new(:six, :hearts)])
      hand.sort_set!
      expect(hand.flush).to eq(false)
    end

  end

  describe '#straight' do
    it "should return [handtype, relavent] if hand is a straight" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:eight, :hearts),
        Card.new(:nine, :hearts), Card.new(:jack, :hearts),
        Card.new(:queen, :hearts)])
      hand.sort_set!
      expect(hand.straight).to eq([:straight, :queen])
    end

    it "should return false if not a straight" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:jack, :clubs),
        Card.new(:queen, :hearts), Card.new(:three, :hearts),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.straight).to eq(false)
    end

  end

  describe '#evaluate_hand' do


    it "should resolve a high card hand"
      # hand.instance_variable_set(:@set,
      #   [Card.new(:ten, :hearts), Card.new(:eight, :clubs),
      #   Card.new(:four, :hearts), Card.new(:two, :clubs),
      #   Card.new(:six, :hearts)])
      # expect(hand.evaluate_hand).to eq([:high_card, :ten])


    it "should resolve a pair hand"
      # hand.instance_variable_set(:@set,
      #   [Card.new(:ten, :hearts), Card.new(:eight, :clubs),
      #   Card.new(:eight, :hearts), Card.new(:two, :clubs),
      #   Card.new(:six, :hearts)])
      # expect(hand.evaluate_hand).to eq([:pair, :eight])






    # let(:set) { [Card.new(:ten, :hearts), Card.new(:eight, :clubs),
    #   Card.new(:four, :hearts), Card.new(:five, :clubs),
    #   Card.new(:six, :hearts)] }
    it "should resolve an unknown hand"
      #expect(hand.evaluate_hand).to eq([:high_card, :ten])

  end

end