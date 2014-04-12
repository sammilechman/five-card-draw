class Player

	attr_accessor :purse, :hand

	def initialize(buy_in)
		@purse = buy_in
		@hand = nil
	end

end