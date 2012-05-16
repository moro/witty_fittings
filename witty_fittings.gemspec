# -*- encoding: utf-8 -*-
require File.expand_path('../lib/witty_fittings/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["moro"]
  gem.email         = ["moronatural@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "witty_fittings"
  gem.require_paths = ["lib"]
  gem.version       = WittyFittings::VERSION

  gem.add_dependency "activerecord", [">= 3.0"]

  gem.add_development_dependency "rspec", [">= 2.0"]
  gem.add_development_dependency "rake"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "database_cleaner"

  gem.add_development_dependency "aruba"
  gem.add_development_dependency "cucumber"
end
