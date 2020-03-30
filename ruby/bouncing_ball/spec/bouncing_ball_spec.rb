require 'byebug'
require_relative '../lib/bouncing_ball.rb'

RSpec.describe BouncingBall do
  def test_conditions
    [
      {parameters: [3,  0.66, 1.5], expected: 3},
      {parameters: [30, 0.66, 1.5], expected: 15},
      {parameters: [30, 0.75, 1.5], expected: 21},
      {parameters: [30, 0.4,  10],  expected: 3},
      {parameters: [40, 1,    10],  expected: -1},
      {parameters: [-5, 0.66, 1.5], expected: -1}
    ].freeze
  end

  context 'when accepting parameters' do
    it 'requires height (h) to be positive' do
      expect(described_class.call(0, 0.66, 1.5)).to eq(-1)
      expect(described_class.call(-1.0, 0.66, 1.5)).to eq(-1)
    end

    it 'requires bounce to be between zero and one, non inclusive' do
      expect(described_class.call(1, 0, 1.5)).to eq(-1)
      expect(described_class.call(1, 1.0, 1.5)).to eq(-1)
    end

    it 'requires window to be positive and less than h' do
      expect(described_class.call(1.5, 1.5, 0)).to eq(-1)
      expect(described_class.call(1, 1, 1)).to eq(-1)
    end
  end

  context 'when the first bounce is too low in respect of the window' do
    it 'the ball is seen only once' do
      expect(described_class.call(2.0, 0.1, 1.5)).to eq 1
    end

    it 'the bouncing height is too low even if it is exactly equal to the window height' do
      expect(described_class.call(2.0, 0.5, 1.0)).to eq 1
    end
  end

  context 'when bouncing once over the window' do
    it 'is seen thrice' do
      expect(described_class.call(3.0, 0.50, 1.0)).to eq 3
    end
  end

  context 'with some example cases' do
    it 'is seen the correct number of times' do
      passed = test_conditions.reduce(true) { |ok, condition|
        n = described_class.call(*condition[:parameters])
        ok && (n == condition[:expected])
      }

      expect(passed).to be true
    end

    it 'is always seen an odd number of times from the window' do
      odd = test_conditions.reduce(true) { |o, condition|
        if condition[:expected] > 0
          n = described_class.call(*condition[:parameters])
          o && n.odd?
        else
          o
        end
      }

      expect(odd).to be true
    end
  end
end
