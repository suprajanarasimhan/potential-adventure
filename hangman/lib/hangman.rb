#TODO Change GitHub email.
#TODO If I already guessed a letter - repeated.

#TODO If I hit CTRL+C, gracefully abort.
#TODO Move all literals (including those that are part of interpolation statements) to en.yml.
#TODO Replace the "Remaining guesses:" count with images.
#TODO Separate I/O statements from game logic.
#TODO Consolidate initialization calls in a single file.
#TODO Support a way to globally require byebug debugger.
require 'byebug'
require_relative '../lib/translations.rb'
require_relative "../config/initializers/lib_file_loader.rb"

class Hangman
  include LibFileLoader
  include Translations
  extend Logging

  class << self
    attr_accessor :misses, :remaining_guesses, :secret

    def run
      run_initializers
      run_intro
      run_game
    end

    def run_initializers
      # Initialize misses to an empty Array.
      @@misses = []
      @@remaining_guesses = 10
    end

    #TODO Load all "intro" values in a single line.
    def run_intro
      puts I18n.t "intro.lets_play"
      puts I18n.t "intro.explain"
      puts I18n.t "intro.get_word"
    end

    def run_game
      self.choose_secret_word
      self.continue_or_exit
    end

    def choose_secret_word
      secret_word = Dictionary.get_word
      self.secret = Secret.new(secret_word)
      logger.info "**** The secret the word I chose is #{self.secret.word}. ****"
      puts I18n.t "get_word.got_it"
    end

    #TODO Play another round?
    #TODO Write tests for:
    #     tally
    #     stored misses
    #     repeated
    #     invalid guesses - no penalizing
    #     win due to exact guess - immediate
    #     win due to exact guess - cumulative
    #
    def continue_or_exit
      if @@remaining_guesses <= 0
        handle_exit('fail')
      else
        print_game_status
        self.guess_and_check
      end
    end

    def handle_exit(status_str)
      puts I18n.t "exit.#{status_str}", secret: self.secret.word
      exit
    end

    def guess_and_check
      guess = get_guess
      if guess.valid?
        run_check(guess)
      else
        puts I18n.t "guess.invalid"
        guess_and_check
      end
    end

    def get_guess
      puts I18n.t "guess.enter"
      guess = Guess.get
    end

    def print_game_status
      puts I18n.t 'game.status.start'
      puts "Secret: #{secret.printable_guess}"
      puts "\nMisses: #{printable_misses}"
      puts "# of Remaining guesses: #{@@remaining_guesses}"
    end

    def printable_misses
      @@misses.empty? ? "None." : @@misses
    end

    def run_check(guess)
      guessed_char = guess.value
      result = Checker.run(self.secret.word, guessed_char)

      print "You guessed: #{guessed_char}. ==> "
      logger.debug "result: #{result}"

      handle_result(result, guessed_char)
      continue_or_exit
    end

    def handle_result(result, guessed_char)
      case result.to_s
      when "Checker::ExactMatch"
        handle_exact_match!
      when "Checker::Included"
        handle_included!(guessed_char)
      else
        handle_missed!(guessed_char)
      end
    end

    def handle_exact_match!
      puts I18n.t 'guess.exact_match'
      handle_exit('success')
    end

    def handle_included!(guessed_char)
      puts I18n.t 'guess.included'
      self.secret.update!(guessed_char)
      handle_exit('success') if secret.revealed?
    end

    def handle_missed!(guessed_char)
      puts I18n.t 'guess.missed'
      @@misses << guessed_char
      @@remaining_guesses -= 1
    end
  end
end

#TODO Move to a file "main.rb"
Hangman.run
