require 'oystercard'
describe Oystercard do 
	let(:entry_station){"leatherhead"}
	let(:exit_station){"wallington"}
	let(:journey){{entry_station: entry_station, exit_station: exit_station}}
	it "checks the balance" do
		expect(subject.balance).to eq 0
	end
	
	describe '#top_up' do 
		it "tops up balance" do 
			subject.top_up(10)
			expect(subject.balance).to eq 10
		end
		
		it "top up over balance limit" do
			maximum_balance = Oystercard::MAXIMUM_BALANCE
			expect{subject.top_up(maximum_balance + 1)}.to raise_error "You cannot top up your balance above £#{maximum_balance}"
		end
	end
	describe '#in_journey?' do
	  it "checks if in journey when not" do 
		  expect(subject).not_to be_in_journey
	  end
  end
	describe '#touch_in' do 
	  it "card touches in and changes journey to true" do 
	  	subject.top_up(1)
	   	subject.touch_in(entry_station)
	    expect(subject).to be_in_journey 
  	end
  	it 'cant touch in if balance below minimum_balance' do 
  		minimum_balance = Oystercard::MINIMUM_BALANCE
  		expect{subject.touch_in(entry_station)}.to raise_error "You need £#{minimum_balance} to travel"
  	end
  	
  	it 'stores entry station' do 
  		subject.top_up(1)
  		subject.touch_in(entry_station)
  		expect(subject.journeys[-1][:entry_station]).to eq entry_station
  	end
  end
  describe '#touch_out' do 
    it 'card touches out and changes journey to false' do
    	subject.top_up(1)
      subject.touch_out(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    it 'balance reduced by minimum_balance when touching out' do 
    	minimum_balance = Oystercard::MINIMUM_BALANCE
    	subject.top_up(10)
      subject.touch_out(entry_station)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-minimum_balance)
    end
    it 'station is nil when touch out of station' do 
    	subject.top_up(1)
    	subject.touch_out(entry_station)
    	subject.touch_out(exit_station)
    	expect(subject.journeys[-1][:exit_station]).to eq exit_station
    end
  end
  it 'journey list is empty by default' do 
  	expect(subject.journeys).to eq [{}]
  end
  it 'touching in and out creates a journey' do 
  	subject.top_up(1)
  	subject.touch_in(entry_station)
  	subject.touch_out(exit_station)
  	expect(subject.journeys).to include journey
  end
end
