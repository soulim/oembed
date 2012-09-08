# encoding: utf-8
require File.expand_path('../lib/oembed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Soulim"]
  gem.email         = ["soulim@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "oembed"
  gem.require_paths = ["lib"]
  gem.version       = Oembed::VERSION

  gem.add_development_dependency 'rspec', '~> 2.11.0'
  gem.add_development_dependency 'simplecov', '~> 0.6.4'
end
