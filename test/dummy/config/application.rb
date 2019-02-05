require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "jsql"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    Jsql.configure do |config|
      config.api_key = '==iSqF8rKvVeSgqudKDOXpjiFgGMJh1PbeouIz9IW/YQ==9CI8ox66gogpoSXm6yrU'
      config.member_key = 'Z6kEovODxAv2I5hKekMyUw=='
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

