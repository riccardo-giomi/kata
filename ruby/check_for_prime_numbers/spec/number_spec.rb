# rubocop:disable Style/BlockDelimiters
require_relative '../lib/number.rb'

RSpec.describe Number do
  def should_be_prime(number)
    puts "--> #{number}"
    expect(Number.new(number).prime?).to be_truthy
  end

  def should_not_be_prime(number)
    puts "--> #{number}"
    expect(Number.new(number).prime?).to be_falsy
  end

  describe 'can tell if a number is prime using #prime?' do
    example { should_not_be_prime(0) }
    example { should_not_be_prime(1) }
    example { should_be_prime(2) }
    example { should_be_prime(3) }
    example { should_not_be_prime(4) }
    example { should_be_prime(5) }
    example { should_be_prime(7) }
    example { should_not_be_prime(9) }
    example { should_be_prime(11) }
    example { should_be_prime(13) }
    example { should_not_be_prime(25) }
    example { should_be_prime(29) }
    example { should_not_be_prime(49) }
    example { should_be_prime(571) }
  end
end
