def RSpec.root
  @spec_root ||= Pathname.new(File.dirname(__FILE__))
end

$: << File.expand_path('../lib', File.dirname(__FILE__))
require 'active_record_models'

RSpec.configure do |config|
  config.mock_with :rspec
end

