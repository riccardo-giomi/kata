require_relative '../../lib/bowling_game'

RSpec.describe BowlingGame do
  def throw_n_times(n:, pins_down:)
    game = described_class.new
    n.times { game.roll(pins_down) }
    game
  end

  describe '#roll' do
    context 'with a valid argument' do
      it 'receives the number of pins knocked down' do
        expect { described_class.new.roll(1) }.to_not raise_error
      end

      it 'raises an error if the game is finished' do
        expect { throw_n_times(n: 21, pins_down: 1) }.to raise_error BowlingGame::GameEnded
      end
    end

    context 'with an invalid argument' do
      it 'raises an error if the argument is more than 10' do
        expect { described_class.new.roll(11) }.to raise_error ArgumentError
      end

      it 'raises an error if the argument is less than 0' do
        expect { described_class.new.roll(-1) }.to raise_error ArgumentError
      end

      it 'raises an error if the argument is not a number' do
        expect { described_class.new.roll('ten') }.to raise_error ArgumentError
      end

      it 'raises an error if more than 10 pins where knocked down in a single frame' do
        game = described_class.new

        game.roll(5)
        expect { game.roll(6) }.to raise_error ArgumentError
      end

      it 'raises an error if there are more than 20 pins total in the last frame and there was a spare' do
        skip('Should be in the spec for BowlingGame::Frame')
      end
    end
  end

  describe '#ended?' do
    context 'when there are no spares nor strikes' do
      it 'returns true if the ball was thrown 20 times' do
        game = throw_n_times(n: 20, pins_down: 1)

        expect(game.ended?).to be true
      end

      it 'returns false if the ball was not thrown 20 times' do
        game = throw_n_times(n: 10, pins_down: 1)

        expect(game.ended?).to be false
      end
    end
  end

  describe '#score' do
    context 'when called at the end of a game' do
      def throw(rolls: [])
        game = described_class.new
        rolls.each do |pins_down|
          game.roll(pins_down)
        end
        game
      end

      it 'scores 0 for a complete set of misses' do
        expect(throw_n_times(n: 20, pins_down: 0).score).to be_zero
      end

      it 'scores 20 points if all throws knock down 1 pin' do
        expect(throw_n_times(n: 20, pins_down: 1).score).to eq 20
      end

      it "scores 29 points if all throws knock down 1 pin plus there's one spare" do
        game = throw(rolls: [1, 9] + Array.new(18, 1))
        expect(game.score).to eq 29
      end

      it 'scores 180 points if all results are spares (9 and 1) except for the last (9 and 0)' do
        game = throw(rolls: [9, 1] * 9 + [9, 0])
        expect(game.score).to eq 180
      end

      it 'scores 187 points if all results are spares (9, 1) and the extra throw is not a strike (6)' do
        game = throw(rolls: [9, 1] * 10 + [6])
        expect(game.score).to eq 187
      end

      it 'scores 191 points if all results are spares (9, 1) and the extra throw is a strike' do
        game = throw(rolls: [9, 1] * 10 + [10])
        expect(game.score).to eq 191
      end

      it 'scores 10 points if there was a strike first, followed by all zeros' do
        game = throw(rolls: [10]. [0] * 18)
        expect(game.score).to eq 10
      end

      xit 'scores 300 points if all results are strikes' do
        game = throw(rolls: [10] * 12)
        pp game.inspect_frames
        expect(game.score).to eq 300
      end
    end

    context 'when called before the end of the game' do
      it 'returns an error' do
        game = throw_n_times(n: 19, pins_down: 2)
        expect { game.score }.to raise_error BowlingGame::GameNotEndedYet
      end
    end
  end
end
