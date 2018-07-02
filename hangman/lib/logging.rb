require 'logger'
#TODO Avoid this global scope.
LOG_LEVEL = Logger::INFO

module Logging
  # When it's mixed in, this "instance" method of this module simply calls the
  # class method of this module.
  #
  def logger
    Logging.logger
  end
  
  # This class method of the module initialized an "instance" variable @logger if
  # it is not already initialized. Otherwise it uses the existing Logger instance.
  #
  #TODO Determine why is this not a class variable @@?
  #TODO Allow passsing log level via command line args or config file.
  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
      @logger.level = LOG_LEVEL
      @logger
    end
  end
end
