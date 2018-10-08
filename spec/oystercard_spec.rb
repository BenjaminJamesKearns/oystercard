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
		
		it "top up over balance limit" do
			maximum_balance = Oystercard::MAXIMUM_BALANCE
			expect{subject.top_up(maximum_balance + 1)}.to raise_error 'You cannot top up your balance above £90'
		end
	end
	
	describe '#deduct' do 
		it "deduct from balance" do 
			subject.top_up(10)
			subject.deduct(5)
			expect(subject.balance).to eq 5
		end
	end
end