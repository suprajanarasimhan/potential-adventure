require 'i18n'

module Translations
  def self.included(base)
  	Translations.run
  end

  class << self
  	def run
	  I18n.config.available_locales = :en
	  I18n.load_path << 'config/locales/en.yml'
	end
  end
end