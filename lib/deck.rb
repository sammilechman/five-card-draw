class Deck
  attr_reader :card_list

  def initialize
    @card_list = []
    self.generate_deck
    self.shuffle
  end

  def generate_deck
    suits = [:hearts, :diamonds, :clubs, :spades]
    faces = [:two, :three, :four, :five, :six, :seven, :eight, :nine,
      :ten, :jack, :queen, :king, :ace]
      suits.each do |suit|
        faces.each do |face|
          @card_list << Card.new(face, suit)
        end
      end
  end

  def shuffle
    @card_list.shuffle!
  end

  def draw_cards(num)
    [].tap do |drawn_cards|
      num.times { drawn_cards << @card_list.pop }
    end

  end

end