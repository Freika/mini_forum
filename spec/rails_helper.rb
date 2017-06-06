# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
require 'support/database_cleaner'
require 'devise'
# require 'sidekiq/testing'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  config.include Warden::Test::Helpers
  config.include Devise::TestHelpers, type: :controller
  config.include ActionView::RecordIdentifier
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    phantomjs_logger: Rails.root.join('log', 'poltergeist.log'),
    inspector: true
  )
end

Capybara.javascript_driver = :poltergeist

Capybara.server_port = 3001
Capybara.app_host = 'http://localhost:3001'
# OmniAuth.config.test_mode = true
