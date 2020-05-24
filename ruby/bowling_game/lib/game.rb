class Game
  attr_reader :score
  def initialize
    @rolls, @score = [], 0
  end

  def round
    @rolls.size
  end

  def roll(n)
    fail InvalidRoll unless n.between?(0, 10)
    fail GameEndedError if ended?
    @rolls << n

    @score += n if extra_score_applies? && !fill_ball?
    @score += n

    @rolls << 0 if round.odd? && n == 10
  end

  def ended?
    return false if round < 20
    !fill_ball_allowed?
  end

  private

  def fill_ball_allowed?
    return true if fill_ball_allowed_by_spare?
    round == 21 && (@rolls[18] == 10 || @rolls[19] == 10) && @rolls[20] != 10
  end

  def fill_ball_allowed_by_spare?
    round == 20 && @rolls[18..19].sum == 10
  end

  def fill_ball?
    round > 20
  end

  def previous_frame_spare?
    first   = round.even? ? round - 4 : round - 3
    second  = round.even? ? round - 3 : round - 2

    return false if first < 0

    @rolls[first] < 10 && @rolls[first..second].sum == 10
  end

  def previous_frame_strike?
    first = round.even? ? round - 4 : round - 3
    second  = round.even? ? round - 3 : round - 2

    return false if first < 0

    @rolls[first] == 10
  end

  def extra_score_applies?
    (round.odd? && previous_frame_spare?) || previous_frame_strike?
  end
end

class GameEndedError < StandardError; end
class InvalidRoll    < StandardError; end
