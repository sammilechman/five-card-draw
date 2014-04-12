class Player

	attr_accessor :purse, :hand, :folded

	def initialize(buy_in)
		@purse = buy_in
		@hand = nil
		@folded = false
	end

end