require_relative '../../lib/logging.rb'

module LibFileLoader
  #TODO Make it so `include Logging` is sufficient, rather than `extend Logging.`
  extend Logging

  def self.included(base)
    LibFileLoader.run
  end

  class << self

    def run
      Dir.entries('lib').each do |file_name|
        logger.debug "File name: #{file_name}"
        logger.info File.dirname(__FILE__)
        next if ['.', '..', 'hangman.rb'].include?(file_name)
        require_relative "../../lib/#{file_name}"
      end
    end
  end

end
