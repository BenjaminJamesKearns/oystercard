class Oystercard
	
	attr_reader :balance, :entry_station
	MAXIMUM_BALANCE = 90
	MINIMUM_BALANCE = 1
	def initialize 
		@balance = 0
	end
	
	def top_up(amount)
		fail "You cannot top up your balance above £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
		@balance += amount
	end
	
	def in_journey?
	  !!entry_station
	end
	
	def touch_in(station)
		fail "You need £#{MINIMUM_BALANCE} to travel" if @balance < MINIMUM_BALANCE
		@entry_station = station
	end
	
	def touch_out
		deduct(MINIMUM_BALANCE)
		@entry_station = nil
	end
	
	private 
	
	def deduct(amount)
		@balance -= amount
	end
end