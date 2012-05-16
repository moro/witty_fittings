require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rake'
require 'rspec/core/rake_task'
require "cucumber/rake/task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
end

Cucumber::Rake::Task.new(:cucumber)

task :default => [:spec, :cucumber]


