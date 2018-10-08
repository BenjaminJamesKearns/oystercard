class Oystercard
	
	attr_reader :balance
	MAXIMUM_BALANCE = 90
	def initialize 
		@balance = 0
	end
	
	def top_up(amount)
		fail 'You cannot top up your balance above £90' if @balance + amount > MAXIMUM_BALANCE
		@balance += amount
	end
end