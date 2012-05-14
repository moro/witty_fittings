def RSpec.root
  @spec_root ||= Pathname.new(File.dirname(__FILE__))
end

$: << File.expand_path('../lib', File.dirname(__FILE__))
require 'active_record_models'

require 'database_cleaner'
DatabaseCleaner.strategy = :transaction



RSpec.configure do |config|
  config.mock_with :rspec
  config.before do
    DatabaseCleaner.start
  end
  config.after do
    DatabaseCleaner.clean
  end
end

