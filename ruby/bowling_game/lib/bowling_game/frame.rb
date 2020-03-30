class BowlingGame
  class Frame
    attr_reader :frame_number, :previous_frame
    attr_accessor :score

    def initialize(previous_frame = nil)
      @pins_down = []
      @score     = 0

      @previous_frame = previous_frame
      @frame_number   = 1 + (@previous_frame&.frame_number || 0)
    end

    def record(pins_down)
      validate_roll(pins_down)

      @pins_down << pins_down
      @score += pins_down

      if one_throw? && @previous_frame&.spare?
        @previous_frame.score += pins_down
      elsif (two_throws? || strike?) && @previous_frame&.strike?
        @previous_frame.score += score
      end

      frame_complete_and_not_last? ? Frame.new(self) : self
    end

    def total_score
      @previous_frame.nil? ? score : score + @previous_frame.total_score
    end

    def game_ended?
      last_frame? && complete?
    end

    def strike?
      @pins_down.first == 10
    end

    def spare?
      return false if strike? || @pins_down.size < 2

      @pins_down[0] + @pins_down[1] == 10
    end

    def to_h
      {
        n: @frame_number,
        pins_down: @pins_down,
        score: @score
      }
    end

    def all_frames
      return [to_h] if @previous_frame.nil?

      @previous_frame.all_frames + [to_h]
    end

    private

    def validate_roll(pins_down)
      fail ArgumentError, 'Number of pins must be between zero and ten' unless (0..10).include?(pins_down)

      fail GameEnded if game_ended?

      validate_total_pins_down(pins_down) if @pins_down.size >= 1

      true
    end

    def validate_total_pins_down(pins_down)
      max_pins = 10

      if last_frame?
        if spare?
          max_pins = 20
        elsif @pins_down[0..1] == [10, 10]
          max_pins = 30
        elsif strike?
          max_pins = 20
        end
      end

      too_many_pins = pins_down + @pins_down.reduce(:+) > max_pins
      fail ArgumentError, 'Too many pins for a single frame!' if too_many_pins
    end

    def last_frame_complete?
      return @pins_down.size == 3 if spare? || strike?

      two_throws?
    end

    def one_throw?
      @pins_down.size == 1
    end

    def two_throws?
      @pins_down.size == 2
    end

    def complete?
      last_frame? ? last_frame_complete? : two_throws? || strike?
    end

    def last_frame?
      @frame_number == 10
    end

    def frame_complete_and_not_last?
      complete? && !last_frame?
    end
  end
end
