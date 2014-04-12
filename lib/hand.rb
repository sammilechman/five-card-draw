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
  

  def evaluate
		return self.straight_flush if straight_flush
		return self.four_of_a_kind if four_of_a_kind
		return self.full_house if full_house
		return self.flush if flush
		return self.straight if straight
		return self.three_of_a_kind if three_of_a_kind
		return self.two_pair if two_pair
		return self.pair if pair
		return self.high_card if high_card
  end
  
  
  def high_card
  	[:highcard].tap do |to_return|
  		@set.reverse.each { |card| to_return << card.face }
  	end
  end


  def pair
  	face_list = []
  	@set.each { |card| face_list << card.face }
  	
  	pairs = []
  	
  	pairs << face_list[0] if face_list[0] == face_list[1] &&
  		face_list[0] != face_list[2]
  	pairs << face_list[1] if face_list[1] == face_list[2] &&
  		face_list[1] != face_list[0] && face_list[1] != face_list[3]
  	pairs << face_list[2] if face_list[2] == face_list[3] &&
  		face_list[2] != face_list[1] && face_list[2] != face_list[4]
  	pairs << face_list[3] if face_list[3] == face_list[4] &&
  		face_list[3] != face_list[2]
  	
  	face_list.delete_if { |card_value| pairs.include?(card_value) }
  	
  	if pairs.uniq.count != 0
  		return [:pair, pairs[0]].tap do |array|
  			array << face_list.last << face_list[1] << face_list.first
  		end
  	end
  	false
  end


  def two_pair
    face_list = []
  	@set.each { |card| face_list << card.face }
  	
  	pairs = []
  	
  	if face_list[0] == face_list[1] &&
  			face_list[3] == face_list[4]
  				pairs << face_list[0]
  				pairs << face_list[3]
  	end
  	
  	2.times do |idx|
  		if face_list[idx] == face_list[idx + 1] &&
  			face_list[idx + 2] == face_list[idx + 3]
  				pairs << face_list[idx]
  				pairs << face_list[idx + 2]
  		end
  	end
  	
  	face_list.delete_if { |card_value| pairs.include?(card_value) }
  	
  	if pairs.count != 0
  		return [:twopair, pairs[1], pairs[0], face_list.first]
  	end
  	false
  end


  def three_of_a_kind
  	face_list = []
  	@set.each { |card| face_list << card.face }
  	
  	threes = []
  	3.times do |idx|
  		threes << face_list[idx] if face_list[idx] == face_list[idx + 1] &&
  			face_list[idx] == face_list[idx + 2]
  	end
  	
  	if threes.count != 0
  		return [:threeofakind, threes[0]]
  	end
  	false
  end
  

  def straight
    (0...(@set.count - 1)).each do |idx|
      return false if @set[idx + 1].value - @set[idx].value != 1
    end
    return [:straight, highest_card(@set)]
  end
  

  def flush
    return [:flush, highest_card(@set)] if @set.all? do |card|
      card.suit == @set[0].suit
    end
    false
  end
  

  def full_house
  	if self.three_of_a_kind && self.pair
  		return [:fullhouse, self.three_of_a_kind[1]]
  	end
  	false
  end
  

  def four_of_a_kind
  	face_list = []
  	@set.each { |card| face_list << card.face }
  	
  	fours = []
  	2.times do |idx|
  		fours << face_list[idx] if face_list[idx] == face_list[idx + 1] &&
  			face_list[idx] == face_list[idx + 2] &&
  			face_list[idx] == face_list[idx + 3]
  	end
  	
  	if fours.count != 0
  		return [:fourofakind, fours[0]]
  	end
  	false
  end
  

  def straight_flush
		if self.straight && self.flush
			return [:straightflush, highest_card(@set)]
		end
		false
  end
  

  def sort_set!
    @set.sort_by! { |card| card.value }
  end
  

  def highest_card(cards)
    cards.last.face
  end
  

end