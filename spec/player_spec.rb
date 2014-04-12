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
		
		it 'should initialize with folded set to false' do
			expect(player.folded).to eq(false)
		end
	end
	
	describe '#place_bet' do
		it 'should subtract the bet amount from the purse' do
			player.purse = 50
			player.place_bet(5)
			expect(player.purse).to eq(45)
		end
		
		it 'should automatically fold if player tries to bet more than the purse' do
			player.purse = 10
			player.place_bet(15)
			expect(player.folded).to eq(true)
		end
	end
		
	describe '#see_bet(current_bet)' do		
		it 'should not allow the player to have negative money, but allow them to see any bet' do
			player.purse = 10
			player.see_bet(20)
			expect(player.purse).to eq(0)
		end
		
		it 'should subtract the bet amount from the players purse' do
			player.purse = 30
			player.see_bet(20)
			expect(player.purse).to eq(10)
		end
		
	end
	
	describe '#raise_bet(current_bet)' do		
		it 'automatically fold if they try and bet more than their purse' do
			player.purse = 30
			player.raise_bet(20)
			expect(player.folded).to eq(true)
		end
		
		it 'should subtract the bet amount from the players purse' do
			player.purse = 50
			player.raise_bet(20)
			expect(player.purse).to eq(10)
		end
		
	end
	
	describe '#fold' do		
		it 'should set folded equal to true' do
			player.fold
			expect(player.folded).to eq(true)
		end
	end
	
	
	
end