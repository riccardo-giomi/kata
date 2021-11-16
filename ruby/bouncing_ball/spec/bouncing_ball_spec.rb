require_relative '../lib/bouncing_ball.rb'

RSpec.describe 'bouncing_ball' do
  describe 'with invalid parameters' do
    it 'returns -1 if the window is higher than the height the ball starts falling from' do
      h = 1
      b = 0.5
      w = 1

      expect(bouncing_ball(h, b, w)).to eq(-1)
    end

    it 'returns -1 if the "bounce coefficient" is greater or equal to one' do
      h = 2
      b = 1
      w = 1

      expect(bouncing_ball(h, b, w)).to eq(-1)
    end

    it 'returns -1 if the "bounce coefficient" is zero or less' do
      h = 2
      b = 0
      w = 1

      expect(bouncing_ball(h, b, w)).to eq(-1)
    end
  end

  it 'is seen once if the first bounce is below the window' do
    h = 2
    b = 0.4
    w = 1

    expect(bouncing_ball(h, b, w)).to eq(1)
  end

  it 'is seen thrice if the first bounce is over the window' do
    h = 3
    b = 0.66
    w = 1.5

    expect(bouncing_ball(h, b, w)).to eq(3)
  end

  it 'is seen five times if the first two bounces are over the window' do
    h = 4
    b = 0.6
    w = 1

    expect(bouncing_ball(h, b, w)).to eq(5)
  end

  example_group 'acceptance criteria' do
    example do expect(bouncing_ball(30, 0.66, 1.5)).to eq(15) end

    example do expect(bouncing_ball(30, 0.75, 1.5)).to eq(21) end

    example do expect(bouncing_ball(30, 0.4, 10)).to eq(3) end

    example do expect(bouncing_ball(40, 1, 10)).to eq(-1) end

    example do expect(bouncing_ball(-5, 0.66, 1.5)).to eq(-1) end
  end
end
