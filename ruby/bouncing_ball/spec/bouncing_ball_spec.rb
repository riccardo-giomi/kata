# rubocop:disable Style/BlockDelimiters
require_relative '../lib/bouncing_ball'

RSpec.describe BouncingBall do
  describe 'with invalid values' do
    specify 'The height must be more than zero' do
        expect(described_class.call(0, 0.99, 10)).to eq -1
    end
    specify 'the window must be lower than the height' do
        expect(described_class.call(9, 0.99, 10)).to eq -1
    end

    specify 'the window must be lower than the height' do
        expect(described_class.call(9, 0.99, 10)).to eq -1
    end

    specify 'bounce is a Float between 0 and 1 extremes excluded' do
        expect(described_class.call(30, 0.00, 10)).to eq -1
        expect(described_class.call(30, 1.00, 10)).to eq -1
    end

      example { expect(described_class.call(40, 1, 1.5)).to eq -1 }
      example { expect(described_class.call(-5, 0.66, 1.5)).to eq -1 }
  end

  describe 'with valid values' do
    describe 'counts bounces that reach a certain height' do
      example { expect(described_class.call(3, 0.66, 1.5)).to eq 3 }
      example { expect(described_class.call(30, 0.66, 1.5)).to eq 15 }
      example { expect(described_class.call(30, 0.75, 1.5)).to eq 21 }
      example { expect(described_class.call(30, 0.4, 10)).to eq 3 }
    end
  end
end
