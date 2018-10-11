class Station
	def initialize(station)
		@station = station
		@name = @station[:name]
		@zone = @station[:zone]
	end
	attr_reader :name, :zone, :station
end