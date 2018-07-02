class Guess

  #TODO Introduce exceptions to make it impossible to set an invalid value on Guess.
  def initialize(value)
    @value = value
  end
  attr_accessor :value

  def valid?
    return false if self.value.nil? || self.value == ""
    return false unless self.value.is_a?(String)

    # /^$/       => If from start to finish
    # /+/        => String contains one or more
    # /[a-zA-Z]/ => Lowercase or uppercase letters
    #
    if self.value.match(/^[a-zA-Z]+$/)
      true
    else
      false
    end
  end

  class << self
    def get
      guess = self.new(gets.chomp)
    end

    # Both support #include?:
    #   -- String `running_guess` 
    #   -- Array `misses` 
    #
    def repeated?(guessed_char, running_guess, misses)
      guess_downcase = guessed_char.downcase
      running_guess.include?(guess_downcase) || misses.include?(guess_downcase)
    end
  end
end
