require 'prime_factors'

RSpec.describe PrimeFactors do
  describe '#generate' do
    it 'returns no prime factors for an input of "1"' do
      expect(described_class.new.generate(1)).to eq []
    end

    it 'returns the prime factors of "2"' do
      expect(described_class.new.generate(2)).to eq [2]
    end

    it 'returns the prime factors of "3"' do
      expect(described_class.new.generate(3)).to eq [3]
    end

    it 'returns the prime factors of "4"' do
      expect(described_class.new.generate(4)).to eq [2, 2]
    end

    it 'returns the prime factors of "5"' do
      expect(described_class.new.generate(5)).to eq [5]
    end

    it 'returns the prime factors of "6"' do
      expect(described_class.new.generate(6)).to eq [2, 3]
    end

    it 'returns the prime factors of "7"' do
      expect(described_class.new.generate(7)).to eq [7]
    end

    it 'returns the prime factors of "8"' do
      expect(described_class.new.generate(8)).to eq [2, 2, 2]
    end

    it 'returns the prime factors of "9"' do
      expect(described_class.new.generate(9)).to eq [3, 3]
    end

    it 'returns the prime factors of "10"' do
      expect(described_class.new.generate(10)).to eq [2, 5]
    end

    it 'returns the prime factors of "11"' do
      expect(described_class.new.generate(11)).to eq [11]
    end

    it 'returns the prime factors of "12"' do
      expect(described_class.new.generate(12)).to eq [2, 2, 3]
    end

    it 'returns the prime factors of "13"' do
      expect(described_class.new.generate(13)).to eq [13]
    end

    it 'returns the prime factors of "14"' do
      expect(described_class.new.generate(14)).to eq [2, 7]
    end

    it 'returns the prime factors of "15"' do
      expect(described_class.new.generate(15)).to eq [3, 5]
    end

    it 'returns the prime factors of "16"' do
      expect(described_class.new.generate(16)).to eq [2, 2, 2, 2]
    end

    it 'returns the prime factors of "17"' do
      expect(described_class.new.generate(17)).to eq [17]
    end

    it 'returns the prime factors of "18"' do
      expect(described_class.new.generate(18)).to eq [2, 3, 3]
    end

    it 'returns the prime factors of "19"' do
      expect(described_class.new.generate(19)).to eq [19]
    end

    it 'returns the prime factors of "20"' do
      expect(described_class.new.generate(20)).to eq [2, 2, 5]
    end

    it 'returns the prime factors of "21"' do
      expect(described_class.new.generate(21)).to eq [3, 7]
    end

    it 'returns the prime factors of "22"' do
      expect(described_class.new.generate(22)).to eq [2, 11]
    end

    it 'returns the prime factors of "23"' do
      expect(described_class.new.generate(23)).to eq [23]
    end

    it 'returns the prime factors of "24"' do
      expect(described_class.new.generate(24)).to eq [2, 2, 2, 3]
    end

    it 'returns the prime factors of "25"' do
      expect(described_class.new.generate(25)).to eq [5, 5]
    end

    it 'returns the prime factors of "23 * 53 * 199"' do
      expect(described_class.new.generate(23 * 53 * 199)).to eq [23, 53, 199]
    end
  end
end
