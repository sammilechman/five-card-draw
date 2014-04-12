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
  
  describe '#straight_flush' do
    it "should return [handtype, relavent] if hand is a straight flush" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:king, :hearts),
        Card.new(:nine, :hearts), Card.new(:jack, :hearts),
        Card.new(:queen, :hearts)])
      hand.sort_set!
      expect(hand.straight_flush).to eq([:straightflush, :king])
    end

    it "should return false if not a straight flush" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:jack, :clubs),
        Card.new(:queen, :spades), Card.new(:king, :hearts),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.straight_flush).to eq(false)
    end

  end
  
  describe '#four_of_a_kind' do
    it "should return [handtype, relavent] if hand is four of a kind" do
      hand.instance_variable_set(:@set,
        [Card.new(:two, :hearts), Card.new(:ten, :diamonds),
        Card.new(:two, :spades), Card.new(:two, :clubs),
        Card.new(:two, :diamonds)])
      hand.sort_set!
      expect(hand.four_of_a_kind).to eq([:fourofakind, :two])
    end

    it "should return false if not four of a kind" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:ten, :clubs),
        Card.new(:ten, :spades), Card.new(:king, :hearts),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.four_of_a_kind).to eq(false)
    end

  end
  
  describe '#full_house' do
    it "should return [handtype, relavent] if hand is a full house" do
      hand.instance_variable_set(:@set,
        [Card.new(:king, :hearts), Card.new(:ten, :diamonds),
        Card.new(:ten, :spades), Card.new(:king, :clubs),
        Card.new(:king, :spades)])
      hand.sort_set!
      expect(hand.full_house).to eq([:fullhouse, :king])
    end

    it "should return false if not a full house" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:ten, :clubs),
        Card.new(:king, :spades), Card.new(:king, :hearts),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.full_house).to eq(false)
    end

  end

	describe '#three_of_a_kind' do
    it "should return [handtype, relavent] if hand is a three of a kind" do
      hand.instance_variable_set(:@set,
        [Card.new(:seven, :hearts), Card.new(:seven, :diamonds),
        Card.new(:ten, :spades), Card.new(:queen, :clubs),
        Card.new(:seven, :hearts)])
      hand.sort_set!
      expect(hand.three_of_a_kind).to eq([:threeofakind, :seven])
    end

    it "should return false if not a three of a kind" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:ten, :clubs),
        Card.new(:king, :spades), Card.new(:king, :hearts),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.three_of_a_kind).to eq(false)
    end

  end
  
  describe '#two_pair' do
    it "should return [handtype, relavent] if hand is a two pair" do
      hand.instance_variable_set(:@set,
        [Card.new(:king, :hearts), Card.new(:king, :diamonds),
        Card.new(:six, :spades), Card.new(:six, :clubs),
        Card.new(:queen, :hearts)])
      hand.sort_set!
      expect(hand.two_pair).to eq([:twopair, :king, :six, :queen])
    end

    it "should return false if not two pair" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:ten, :clubs),
        Card.new(:jack, :spades), Card.new(:king, :hearts),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.two_pair).to eq(false)
    end

  end
  
  describe '#pair' do
    it "should return [handtype, relavent] if hand is a pair" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:ten, :diamonds),
        Card.new(:six, :spades), Card.new(:queen, :clubs),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.pair).to eq([:pair, :ten, :ace, :queen, :six])
    end

    it "should return false if not a pair" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:two, :clubs),
        Card.new(:six, :spades), Card.new(:king, :hearts),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.pair).to eq(false)
    end

  end
  
  describe '#high_card' do
    it "should return [handtype, relavent] if hand is a high card" do
      hand.instance_variable_set(:@set,
        [Card.new(:two, :hearts), Card.new(:six, :diamonds),
        Card.new(:ten, :spades), Card.new(:queen, :clubs),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.high_card).to eq([:highcard, :ace, :queen, :ten, :six, :two])
    end

  end

  describe '#evaluate_hand' do

    it "should return [handtype, relavent] if hand is a flush" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:eight, :hearts),
        Card.new(:eight, :hearts), Card.new(:two, :hearts),
        Card.new(:six, :hearts)])
        hand.sort_set!
        expect(hand.evaluate).to eq([:flush, :ten])
    end

    it "should return [handtype, relavent] if hand is a straight" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:eight, :spades),
        Card.new(:nine, :hearts), Card.new(:jack, :hearts),
        Card.new(:queen, :hearts)])
      hand.sort_set!
      expect(hand.evaluate).to eq([:straight, :queen])
    end

    it "should return [handtype, relavent] if hand is a straight flush" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:king, :hearts),
        Card.new(:nine, :hearts), Card.new(:jack, :hearts),
        Card.new(:queen, :hearts)])
      hand.sort_set!
      expect(hand.evaluate).to eq([:straightflush, :king])
    end

    it "should return [handtype, relavent] if hand is four of a kind" do
      hand.instance_variable_set(:@set,
        [Card.new(:two, :hearts), Card.new(:ten, :diamonds),
        Card.new(:two, :spades), Card.new(:two, :clubs),
        Card.new(:two, :diamonds)])
      hand.sort_set!
      expect(hand.evaluate).to eq([:fourofakind, :two])
    end

    it "should return [handtype, relavent] if hand is a full house" do
      hand.instance_variable_set(:@set,
        [Card.new(:king, :hearts), Card.new(:ten, :diamonds),
        Card.new(:ten, :spades), Card.new(:king, :clubs),
        Card.new(:king, :spades)])
      hand.sort_set!
      expect(hand.evaluate).to eq([:fullhouse, :king])
    end

    it "should return [handtype, relavent] if hand is a three of a kind" do
      hand.instance_variable_set(:@set,
        [Card.new(:seven, :hearts), Card.new(:seven, :diamonds),
        Card.new(:ten, :spades), Card.new(:queen, :clubs),
        Card.new(:seven, :hearts)])
      hand.sort_set!
      expect(hand.evaluate).to eq([:threeofakind, :seven])
    end

    it "should return [handtype, relavent] if hand is a two pair" do
      hand.instance_variable_set(:@set,
        [Card.new(:king, :hearts), Card.new(:king, :diamonds),
        Card.new(:six, :spades), Card.new(:six, :clubs),
        Card.new(:queen, :hearts)])
      hand.sort_set!
      expect(hand.evaluate).to eq([:twopair, :king, :six, :queen])
    end
  
    it "should return [handtype, relavent] if hand is a pair" do
      hand.instance_variable_set(:@set,
        [Card.new(:ten, :hearts), Card.new(:ten, :diamonds),
        Card.new(:six, :spades), Card.new(:queen, :clubs),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.evaluate).to eq([:pair, :ten, :ace, :queen, :six])
    end
  
    it "should return [handtype, relavent] if hand is a high card" do
      hand.instance_variable_set(:@set,
        [Card.new(:two, :hearts), Card.new(:six, :diamonds),
        Card.new(:ten, :spades), Card.new(:queen, :clubs),
        Card.new(:ace, :hearts)])
      hand.sort_set!
      expect(hand.evaluate).to eq([:highcard, :ace, :queen, :ten, :six, :two])
    end

  end

end