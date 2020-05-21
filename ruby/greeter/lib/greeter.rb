require 'logger'

class Greeter
  def initialize(time: Time.now, logger: Logger.new($stdout))
    @time   = time
    @logger = logger
  end

  def greet(name)
    name = upcase_first_letter(name.strip)
    greeting = case
               when morning?
                 "Good morning #{name}"
               when evening?
                 "Good evening #{name}"
               when night?
                 "Good night #{name}"
               else
                 "Hello #{name}"
               end
    log(name)
    greeting
  end

  private

  def upcase_first_letter(string)
    string[0].upcase + string[1..]
  end

  def morning?
    @time.hour.between?(6, 11)
  end

  def evening?
    @time.hour.between?(18, 21)
  end

  def night?
    @time.hour >= 22 || @time.hour < 6
  end

  def log(name)
    @logger.info("Greeted #{name}.") if @logger
  end
end
