#TODO Requires of 'i18n' should be consolidated.
require_relative '../lib/translations.rb'

class Dictionary
  include Translations

  class << self
    attr_accessor :dictionary

    def dictionary
      @@dictionary ||= Dictionary.new
    end

    #TODO Automatically pass any class method on to the instance.
    def get_word
	    dictionary.get_word
  	end
  end

  #TODO Use an API to pull words from a Oxford English Dictionary. 
  def initialize
  	@words = I18n.t :dictionary
  	@max_word_index = @words.size - 1
  end
  attr_reader :words
  attr_reader :max_word_index

      
  def get_word
    random_index = rand(self.max_word_index)
    self.words[random_index]
  end

end