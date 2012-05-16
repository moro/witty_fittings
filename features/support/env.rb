# coding:utf-8
require 'cucumber/formatter/unicode'
require 'cucumber/rspec/doubles'

require 'active_record_models'

require 'database_cleaner'
DatabaseCleaner.strategy = :transaction

require 'aruba/cucumber'
require File.join(Gem::Specification.find_by_name('rspec-core').full_gem_path, 'features/step_definitions/additional_cli_steps.rb')

