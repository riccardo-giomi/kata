class BouncingBall
  def self.call(height, bounce, window)
    return -1 unless bounce > 0.00 && bounce < 1.00
    return -1 if height <= 0 || height < window

    counter = 0
    while height >= window
      height *= bounce
      counter += height > window ? 2 : 1 # bouncing higher of the window means we see it once more on descent
    end
    counter
  end
end
