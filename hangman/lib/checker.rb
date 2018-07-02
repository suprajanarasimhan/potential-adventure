#TODO Re-evaluate the need for this class. Also, does it need to be a class?
#TODO Do not rely on modules to create status objects.

module Checker
  module Invalid; end
  module Included; end
  module Missing; end
  module ExactMatch; end

  class << self

    # This method tells you whether the current guess is:
    #   - Exactly matches the secret.
    #   - Is included in the secret.
    #   - Is missing from the secret.
    #
    def run(word, current_guess)
      args = [current_guess, word]

      if args.select{|arg| !( arg.is_a?(String) ) }.any?
        raise ArgumentError
      end

      status =
        args.each(&:downcase!)

      if current_guess == word
        Checker::ExactMatch
      elsif current_guess.size == 1 && word.include?(current_guess)
        Checker::Included
      else
        Checker::Missing
      end
    end

  end
end
