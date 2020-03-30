require_relative 'bowling_game/frame'

class BowlingGame
  class GameNotEndedYet < StandardError; end
  class GameEnded       < StandardError; end

  def initialize(frame: Frame.new)
    @current_frame = frame
  end

  def roll(pins_down)
    @current_frame = @current_frame.record(pins_down)
  end

  def ended?
    @current_frame.game_ended?
  end

  def score
    fail GameNotEndedYet unless ended?

    @current_frame.total_score
  end

  def inspect_frames
    @current_frame.all_frames
  end
end
