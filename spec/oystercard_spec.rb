require 'oystercard'
describe Oystercard do 
	it "checks the balance" do
		expect(subject.balance).to eq 0
	end
	
	describe '#top_up' do 
		it "tops up balance" do 
			subject.top_up(10)
			expect(subject.balance).to eq 10
		end
	end
end