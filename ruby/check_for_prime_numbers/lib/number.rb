# frozen_string_literal: true

class Number
  def initialize(number)
    @number = number
  end

  def prime?
    case(@number)
      when 0..1 then return false
      when 2 then return true
      when ->(n) { n.even? } then return false
    end

    # "A composite number must have a factor less than the square root of that number. Otherwise, the number is prime."
    last_candidate = Math.sqrt(@number).floor()

    # No need to test for even numbers
    (3..last_candidate).step(2) do |candidate|
      return false if @number % candidate == 0
    end

    true
  end
end
