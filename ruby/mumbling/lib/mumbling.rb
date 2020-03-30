module Mumbling
  def self.accum(word)
    mumbled_chars = word.chars.map.with_index { |char, index|
      char.upcase << char.downcase * index
    }

    mumbled_chars.join('-')
  end
end
