require_relative '../lib/mumbling'
RSpec.describe Mumbling do
  describe '#accum' do
    example 'with ""' do
      expect(described_class.accum('')).to eq ''
    end

    example 'with "a"' do
      expect(described_class.accum('a')).to eq 'A'
    end

    example 'with "ab"' do
      expect(described_class.accum('ab')).to eq 'A-Bb'
    end

    example 'with "abc"' do
      expect(described_class.accum('abc')).to eq 'A-Bb-Ccc'
    end

    example 'with "abcd"' do
      expect(described_class.accum('abcd')).to eq 'A-Bb-Ccc-Dddd'
    end

    example 'with cwAt' do
      expect(described_class.accum('cwAt')).to eq 'C-Ww-Aaa-Tttt'
    end

    example 'with "RqaEzty"' do
      expect(described_class.accum('RqaEzty')).to eq 'R-Qq-Aaa-Eeee-Zzzzz-Tttttt-Yyyyyyy'
    end
  end
end
