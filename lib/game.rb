require_relative "player"

class Game

	attr_accessor :players, :deck

	def initialize
		@players = []
		@deck = nil
		#welcome_sequence
	end
	
	def welcome_sequence
		system('clear')
		puts "\n\nWelcome to Ultimate Poker 7000\n\n"
		print "Please enter the number of players: "
		num_players = gets.chomp.to_i
		num_players.times do |x|
			puts
			print "Welcome, Player #{x + 1}. What is your name? "
			name = gets.chomp.downcase.capitalize
			puts
			print "What is your buy in, #{name}? "
			buy_in = gets.chomp.to_i
			@players << Player.new(name, buy_in)
		end
		
	end
	
	def deal_opening_hands
		@deck = Deck.new
		@players.each do |player|
			player.hand = Hand.new
			player.hand.draw_initial_hand(@deck)
		end
	end
	
	def display_player_hand(player)
		cards = []
		player.hand.set.each do |card|
			cards << "#{card.face.to_s.capitalize} of #{card.suit.to_s.capitalize}"
		end
		puts cards.join(", ")
	end
	
	def betting_round
	
	end
	
	
	
	

end

g=Game.new
g.players = [Player.new("Sam", 100), Player.new("Bob", 100)]
g.deal_opening_hands

g.players.each { |x| g.display_player_hand(x) }