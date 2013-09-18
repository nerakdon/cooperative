# figure out where we are being loaded from
if $LOADED_FEATURES.grep(/spec\/spec_helper\.rb/).any?
  begin
    raise "foo"
  rescue => e
    puts <<-MSG
  ===================================================
  It looks like spec_helper.rb has been loaded
  multiple times. Normalize the require to:

    require "spec/spec_helper"

  Things like File.join and File.expand_path will
  cause it to be loaded multiple times.

  Loaded this time from:

    #{e.backtrace.join("\n    ")}
  ===================================================
    MSG
  end
end

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../dummy/config/environment', __FILE__)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rails/all'
require 'rspec'
require 'rspec/rails'
require 'capybara/rspec'

require 'capybara/poltergeist'
Capybara.default_wait_time = 60
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :timeout => 60)
end
Capybara.javascript_driver = :poltergeist

require 'factory_girl_rails'
FactoryGirl.definition_file_paths = %w(spec/factories)
FactoryGirl.find_definitions

require 'database_cleaner'
require 'shoulda/matchers'
require 'paperclip/matchers'
require 'w3c_rspec_validators'
require 'cooperative'

include Warden::Test::Helpers
Warden.test_mode!

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/behaviors/**/*.rb"].each {|f| require f}

if defined?(Capybara::Node)
  Capybara::Session.send :include, CapybaraNodeExtensions
  Capybara::Node::Element.send :include, CapybaraNodeExtensions
end

RSpec.configure do |config|
  config.include Capybara::DSL, :type => feature
  config.include Paperclip::Shoulda::Matchers
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end