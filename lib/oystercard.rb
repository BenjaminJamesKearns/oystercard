class Oystercard
	
	attr_reader :balance, :journeys
	MAXIMUM_BALANCE = 90
	MINIMUM_BALANCE = 1
	def initialize 
		@balance = 0
		@journeys = []
		@journey = false
	end
	
	def top_up(amount)
		fail "You cannot top up your balance above £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
		@balance += amount
	end
	
	def in_journey?
	  @journey
	end
	
	def touch_in(station)
		fail "You need £#{MINIMUM_BALANCE} to travel" if @balance < MINIMUM_BALANCE
		@journey = true
		journeys << {entry_station: station}
	end
	
	def touch_out(station)
		deduct(MINIMUM_BALANCE)
		@journey = false
		@journeys[-1][:exit_station] = station
	end
	
	private 
	
	def deduct(amount)
		@balance -= amount
	end
end