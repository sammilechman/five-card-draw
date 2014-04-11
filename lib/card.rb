class Card

  attr_reader :suit, :face

  def initialize(face, suit)
    @suit = suit
    @face = face
  end

  def value
    value_hash = { two: 2, three: 3, four: 4, five: 5,
      six: 6, seven: 7, eight: 8, nine: 9,
      ten: 10, jack: 11, queen: 12, king: 13, ace: 14 }
    value_hash[@face]
  end


end