class Hand
  attr_reader :set
  FACES = [:two, :three, :four, :five, :six, :seven, :eight, :nine,
      :ten, :jack, :queen, :king, :ace]

  def initialize
    @set = []
  end
  

  def draw_initial_hand(deck)
    self.get_cards(deck, 5)
    self.sort_set!
  end
  

  def get_cards(deck, num)
    @set += deck.draw_cards(num)
    self.sort_set!
  end
  

  def discard(*card_idxs)
    card_idxs.sort.reverse.each do |i|
      set.delete_at(i)
    end
  end
  

  def evaluate_hand

  end
  
  
  def high_card
  
  end


  def pair
  
  end


  def two_pair
  
  end


  def three_of_kind
  
  end
  

  def straight
    (0...(@set.count - 1)).each do |idx|
      return false if @set[idx + 1].value - @set[idx].value != 1
    end
    return [:straight, highest_card(set)]
  end
  

  def flush
    return [:flush, highest_card(set)] if set.all? do |card|
      card.suit == set[0].suit
    end
    false
  end
  

  def full_house
  
  end
  

  def four_of_kind
  
  end
  

  def straight_flush

  end
  

  def sort_set!
    @set.sort_by! { |card| card.value }
  end
  

  def highest_card(cards)
    cards.last.face
  end
  

end