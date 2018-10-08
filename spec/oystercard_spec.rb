require 'oystercard'
describe Oystercard do 
	it "checks the balance" do
		expect(subject.balance).to eq 0
	end
end