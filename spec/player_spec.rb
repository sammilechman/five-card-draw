require 'spec_helper'

describe Player do

	subject(:player) { Player.new(100) }
	
	describe '#initialize' do
		
		it 'should initialize with a purse equal to the buy-in' do
			expect(player.purse).to eq(100)
		end
		
		it 'should initialize with an nil hand' do
			expect(player.hand).to eq(nil)
		end
		
		
	end
	
	
	
end