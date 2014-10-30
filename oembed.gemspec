# encoding: utf-8
require File.expand_path('../lib/oembed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Sulim"]
  gem.email         = ["hello@sul.im"]
  gem.description   = %q{A slim library to work with oEmbed format.}
  gem.summary       = %q{A slim library to work with oEmbed format.}
  gem.homepage      = "http://soulim.github.com/oembed"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "oembed"
  gem.require_paths = ["lib"]
  gem.version       = Oembed::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'fakeweb'
end
