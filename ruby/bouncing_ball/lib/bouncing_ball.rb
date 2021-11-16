def bouncing_ball(h, b, w)
  BouncingBall.new(h, b, w).drop

end

class BouncingBall
  def initialize(h, b, w)
    @h = h
    @b = b
    @w = w
  end

  def drop
    return -1 unless valid_params?

    count = 1
    count += 2 while bounce
    count
  end

  private

  def valid_params?
    valid_window? && valid_bounce?
  end

  def valid_window?
    @w > 0.0 && @w < @h
  end

  def valid_bounce?
    @b > 0.0 && @b < 1.0
  end

  def bounce
    @h *= @b
    return @h > @w
  end
end
