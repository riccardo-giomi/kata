require_relative '../lib/greeter'

RSpec.describe Greeter do

  describe '#greet' do

    def at(hour, minutes=0)
      Time.new(2020, 1, 1, hour, minutes)
    end

    def greet(name, time: at(16), logger: nil)
      described_class.new(time: time, logger: logger).greet(name)
    end

    context 'during the day' do
      it 'greets people' do
        expect(greet('Person')).to eq 'Hello Person'
      end
    end

    context 'in the morning (6AM to 11:59AM)' do
      it 'says good morning at 6AM' do
        greeting = greet('Morning person', time: at(6))
        expect(greeting).to eq 'Good morning Morning person'
      end

      it 'says good morning at 7:30AM' do
        greeting = greet('Morning person', time: Time.new(2020, 1, 1, 7, 30))
        expect(greeting).to eq 'Good morning Morning person'
      end

      it 'says good morning at 11:59AM' do
        greeting = greet('Morning person', time: Time.new(2020, 1, 1, 11, 59))
        expect(greeting).to eq 'Good morning Morning person'
      end

      it 'does not say good morning at 12AM' do
        greeting = greet('Morning person', time: Time.new(2020, 1, 1, 12))
        expect(greeting).to_not eq 'Good morning Morning person'
      end
    end

    context 'in the evening (between 18:00AM and 21:59PM)' do
      it 'says good evening at 18PM' do
        greeting = greet('Mini-me', time: at(18))
        expect(greeting).to eq 'Good evening Mini-me'
      end

      it 'says good evening at 19:25PM' do
        greeting = greet('Mini-me', time: at(19, 25))
        expect(greeting).to eq 'Good evening Mini-me'
      end

      it 'says good evening at 21:59PM' do
        greeting = greet('Mini-me', time: at(21, 59))
        expect(greeting).to eq 'Good evening Mini-me'
      end

      it 'does not say good evening at 22:00PM' do
        greeting = greet('Mini-me', time: at(22))
        expect(greeting).to_not eq 'Good evening Mini-me'
      end
    end

    context 'during the night (between 22:00AM and 5:59AM)' do
      it 'says good night at 22PM' do
        greeting = greet('Sleepyhead', time: at(22))
        expect(greeting).to eq 'Good night Sleepyhead'
      end

      it 'says good night at midnight' do
        greeting = greet('Sleepyhead', time: at(0))
        expect(greeting).to eq 'Good night Sleepyhead'
      end

      it 'says good night at 5:59AM' do
        greeting = greet('Sleepyhead', time: at(5, 59))
        expect(greeting).to eq 'Good night Sleepyhead'
      end

      it 'does not say good night at 6AM' do
        greeting = greet('Sleepyhead', time: at(6))
        expect(greeting).to_not eq 'Good night Sleepyhead'
      end
    end

    it 'trims the input string' do
      expect(greet(" I have spaaaaaaces   \t")).to eq 'Hello I have spaaaaaaces'
    end

    it 'capitalizes the first letter of the name' do
      expect(greet('joseph')).to eq 'Hello Joseph'
    end

    it 'logs in the console every time it is called' do
      expected_output = 'Greeted Myself (I am lonely)'

      expect{ greet('Myself (I am lonely)', logger: Logger.new($stdout)) }.to output(/Greeted/).to_stdout
    end
  end
end
