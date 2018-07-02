require 'logger'

module Logging
  def logger
    Logging.logger
  end
  # When it's mixed in, this "instance" method of this module simply calls the 
  # class method of this module. 

  # This class method of the module initialized an "instance" variable @logger if 
  # it is not already initialized. Otherwise it uses the existing Logger instance.
  #
  # Why is this not a class variable @@?
  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
      @logger.level = Logger::INFO
      @logger
    end
  end
end