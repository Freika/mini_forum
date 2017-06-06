require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MiniForum
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.time_zone = 'UTC'
    config.active_record.default_timezone = :utc

    config.action_dispatch.default_headers['Content-Type'] =
      'text/html; charset=UTF-8'
    config.action_dispatch.default_headers['X-UA-Compatible'] = 'IE=edge'

    config.generators do |g|
      g.test_framework(
        :rspec,
        view_specs:    false,
        request_specs: false,
        routing_specs: false,
        helper_specs:  false
      )
    end
  end
end
