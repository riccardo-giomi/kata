class BouncingBall
  class << self
    def call(height, bounce, window)
      h = height.to_f
      b = bounce.to_f
      w = window.to_f
      return -1 unless valid?(h, b, w)

      result = 1

      loop do
        h *= b
        break if h <= w

        result += 2
      end
      result
    end

    private

    def valid?(height, bounce, window)
      return false unless height.positive?
      return false unless bounce.positive? && bounce < 1.0
      return false unless window.positive? && window < height

      true
    end
  end
end
