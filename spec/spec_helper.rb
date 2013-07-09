require 'rubygems'
require 'spork'
require 'database_cleaner'

Spork.prefork do


  ENV["RAILS_ENV"] ||= 'test'
  ENV["SECRET_TOKEN"] ||= 'thisisatestingsecrettokensinceguarddoesntseemtopickupthe'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  # Add this to load Capybara integration:
  require 'capybara/rspec'
  require 'capybara/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|

    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.use_transactional_fixtures = true

    config.infer_base_class_for_anonymous_controllers = false

    config.order = "random"
  end
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/app/**/*.rb"].each {|f| load f}
  Dir["#{Rails.root}/lib/**/*.rb"].each {|f| load f}

  RSpec.configure do |config|
    config.mock_with :rspec

    config.use_transactional_fixtures = true

    # Database cleaning operations
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
end

# Custom Helper functions

def model_has_columns(model_instance, *columns)
  columns.each do |column|
    model_instance.should respond_to(column)
  end
end
