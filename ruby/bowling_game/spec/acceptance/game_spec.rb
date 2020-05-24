require_relative '../../lib/game'

RSpec.describe Game do

  let (:game) { Game.new }

  context 'when recording a score' do
    it 'needs to be between 0 and 10' do
      expect { game.roll(11) }.to raise_exception InvalidRoll
    end
  end

  context 'without spares or strikes' do
    it 'scores zero in a gutter game' do
      20.times { game.roll(0) }

      expect(game.score).to be_zero
    end

    it 'scores the sum of the pins that were downed' do
      rolls = [5, 2, 3, 3, 6, 2, 7, 1, 9, 0, 2, 4, 6, 2, 6, 3, 9, 0, 8, 1]

      rolls.each do |roll| game.roll(roll) end

      expect(game.score).to eq rolls.sum
    end

    it 'ends with 20 rolls' do
      expect(game.ended?).to be false

      10.times { game.roll(3) }
      expect(game.ended?).to be false

      10.times { game.roll(0) }

      expect(game.ended?).to be true
    end

    it 'does not allow to roll more then twenty times' do
      20.times { game.roll(0) }

      expect { game.roll(0) }.to raise_exception GameEndedError
    end
  end

  context 'with one spare not in the last frame' do 
    it 'counts the roll after the spare twice' do
      game.roll(1)
      game.roll(9)

      expect(game.score).to eq 10

      game.roll(3)

      expect(game.score).to eq 16
    end

    it 'considers [0, 10] a spare, not a strike' do
      rolls = [0, 10, 1, 1]

      rolls.each do |roll| game.roll(roll) end

      expect(game.score).to eq 13
    end

    it 'calculates the score correctly and ends the game at 20 attempts' do
      expect(game.ended?).to be false

      rolls = [5, 2, 3, 3, 6, 2, 7, 0] + [9, 1] + [2] + [4, 6, 2, 6, 3, 9, 0, 8, 1] 

      rolls.each do |roll| game.roll(roll) end

      expect(game.ended?).to be true
      expect(game.score).to eq rolls.sum + 2

      expect { game.roll(10) }.to raise_exception GameEndedError
    end
  end

  context 'with one spare in the last frame' do 
    it 'allows for an extra roll' do
      expect(game.ended?).to be false

      rolls = [5, 2, 3, 3, 6, 2, 7, 0, 3, 1, 2, 4, 6, 2, 6, 3, 9, 0] + [9, 1]

      rolls.each do |roll| game.roll(roll) end

      expect(game.ended?).to be false
      expect(game.score).to eq rolls.sum

      game.roll(9)

      expect(game.ended?).to be true
      expect(game.score).to eq rolls.sum + 9

    end

    it 'does not allow to roll more then twentyone times' do
      rolls = [1, 8, 3, 5, 3, 5, 6, 2, 0, 3, 1, 4, 2, 4, 0, 4, 1, 4] + [9, 1] + [6]

      rolls.each do |roll| game.roll(roll) end

      expect(game.score).to eq rolls.sum
      expect { game.roll(10) }.to raise_exception GameEndedError
    end
  end

  context 'with one strike not in the last frame' do 
    it "will count the strike's frame as completed and add the next frame's score twice" do

      game.roll(10)
      expect(game.round).to eq 2

      game.roll(1)
      game.roll(2)
      expect(game.score).to eq 16

      game.roll(10)

      expect(game.score).to eq 26

      game.roll(1)
      game.roll(2)
      expect(game.score).to eq 32
    end

    it 'does not allow to roll more then nineteen times' do
      rolls = [8, 0, 1, 0, 4, 2, 7, 0, 2, 5, 2, 5] + [10] + [2, 6] + [3, 9, 0, 9]

      rolls.each do |roll| game.roll(roll) end

      expect(game.score).to eq rolls.sum + [2, 6].sum

      expect { game.roll(0) }.to raise_exception GameEndedError
    end
  end

  context 'with one strike in the last frame' do 
    it 'allows for up to two extra rolls' do
      rolls = [8, 0, 1, 0, 4, 2, 7, 0, 2, 5, 2, 5, 2, 6, 3, 9, 0, 9] + [10]

      rolls.each do |roll| game.roll(roll) end

      expect(game.ended?).to be false
      
      game.roll(9)
      game.roll(1)

      expect(game.ended?).to be true
      expect(game.score).to eq rolls.sum + [9, 1].sum
    end
  end

  context 'after an all-spares game' do
    let(:rolls) { [1, 9] + [2, 8] + [3, 7] + [4, 6] +  [5, 5] +  [6, 4] +  [7, 3] +  [8, 2] + [9, 1] + [1, 9] + [10] }

    it 'scores correctly and allowes twentyone attempts' do
      rolls.each do |roll| game.roll(roll) end

      expect(game.score).to eq rolls.sum + [2, 3, 4, 5, 6, 7, 8, 9, 1].sum
      expect { game.roll(10) }.to raise_exception GameEndedError
    end
  end

  context 'after an all-strikes game' do
    let(:rolls) { [10] * 10 + [10] }

    it 'scores correctly and allowes eleven attempts' do
      rolls.each do |roll| game.roll(roll) end

      expect(game.score).to eq rolls.sum + 9 * 10
      expect { game.roll(10) }.to raise_exception GameEndedError
    end
  end

end
