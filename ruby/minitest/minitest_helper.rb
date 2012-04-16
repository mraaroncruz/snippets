# Uncomment if you want awesome colorful output
# require "minitest/pride"

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__) unless @norails || !defined?(Rails)

require "minitest/autorun"
require "minitest/rails"

begin
  require 'turn/autorun'
  Turn.config.format = :progress
rescue LoadError
end

def require_in_directory dir, file
  require File.expand_path("../../#{dir}/#{file}.rb", __FILE__)
end

def require_model object
  require_in_directory "app/models", object
end

def require_lib object
  require_in_directory "lib", object
end

def require_controller object
  require_in_directory "app/controllers", object
end

def require_view ctrl, action
  require_in_directory "app/views/#{ctrl}/#{action}", object
end

unless @norails || !defined?(MiniTest::Rails)

  class MiniTest::Rails::Spec
    # Uncomment if you want to support fixtures for all specs
    # or
    # place within spec class you want to support fixtures for
    # include MiniTest::Rails::Fixtures

    # Add methods to be used by all specs here...

  end

  class MiniTest::Rails::Model

    # Add methods to be used by model specs here...

  end

  MiniTest::Spec.register_spec_type(MiniTest::Rails::Model) do |desc|
    desc.superclass == ActiveRecord::Base
  end

  class MiniTest::Rails::Controller
    include ActionController::TestCase::Behavior
    before do
      @request  = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new
      @routes   = Rails.application.routes
    end

    # Add methods to be used by controller specs here...

  end

  MiniTest::Spec.register_spec_type(/Controller$/, MiniTest::Rails::Controller)

  class MiniTest::Rails::Helper

    # Add methods to be used by helper specs here...

  end

  MiniTest::Spec.register_spec_type(/Helper$/, MiniTest::Rails::Helper)

  class MiniTest::Rails::Mailer

    # Add methods to be used by mailer specs here...

  end

  MiniTest::Spec.register_spec_type(MiniTest::Rails::Mailer) do |desc|
    desc.superclass == ActionMailer::Base
  end
end


