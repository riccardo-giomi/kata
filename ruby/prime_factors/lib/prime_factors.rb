# frozen_string_literal: true

class PrimeFactors
  def generate(number)
    factors = []

    (2..Math.sqrt(number).to_i).each do |n|
      while number % n == 0
        factors << n
        number /= n
      end
    end

    factors << number if number > 1
    factors
  end
end
