require_relative "hand"

class Player

	attr_accessor :purse, :folded, :hand
	attr_reader :name

	def initialize(name, buy_in)
		@name = name
		@purse = buy_in
		@set = nil
		@folded = false
	end
	
	def place_bet(amount)
		@folded = true if amount > @purse
		@purse -=  amount
	end
	
	def see_bet(current_bet)
		@purse = 0 if current_bet > @purse
		@purse -= current_bet if current_bet <= @purse
	end
	
	def raise_bet(current_bet)
		@folded = true if (current_bet * 2) > @purse
		@purse -= (current_bet * 2) if (current_bet * 2) <= @purse
	end
	
	def fold
		@folded = true
	end

end