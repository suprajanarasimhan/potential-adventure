#TODO Move this to an initializer.
class String
  def hangman
  	self.split('').join(' ')
  end
end

class Secret
  include Logging

  def initialize(word)
  	@word = word

  	#TODO Remove unecessary variable `x` from statement.
  	@running_guess = "_"*word.size
  end
  attr_reader :word, :word_array, :running_guess

  def get_indices_for_char(target_char)
  	arr = []
  	word_chars = self.word.split('')
  	word_chars.each_with_index do |char, idx|
  	  arr << idx if char == target_char
  	end
  	arr
  end

  def update!(target_char)
  	indices = get_indices_for_char(target_char)

  	indices.each do |idx|
  	  self.running_guess[idx] = target_char
  	  logger.debug "After updating the value at #{idx}, #{self.printable_guess}."
  	end
  end

  def printable_guess
  	self.running_guess.hangman
  end

  def revealed?
    self.running_guess == self.word
  end

end

