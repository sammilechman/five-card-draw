class Hand
  attr_reader :set

  def initialize
    @set = []
  end

  def draw_initial_hand(deck)
    self.get_cards(deck, 5)
  end

  def get_cards(deck, num)
    @set += deck.draw_cards(num)
  end

  def discard(*card_idxs)
    card_idxs.sort.reverse.each do |i|
      set.delete_at(i)
    end
  end
end