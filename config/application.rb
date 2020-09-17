require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)
module SampleApp
  class Application < Rails::Application
    config.i18n.default_locale = :vi
    config.i18n.available_locales = [:en, :vi]
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.middleware.use I18n::JS::Middleware
  end
end
