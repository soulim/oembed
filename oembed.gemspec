# encoding: utf-8
require File.expand_path('../lib/oembed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Sulim"]
  gem.email         = ["hello@sul.im"]
  gem.description   = %q{A slim library to work with oEmbed format. It has no external dependencies at runtime. All you need to have is Ruby itself.}
  gem.summary       = %q{A slim library to work with oEmbed format.}
  gem.homepage      = "http://soulim.github.com/oembed"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "oembed"
  gem.require_paths = ["lib"]
  gem.version       = Oembed::VERSION

  gem.add_development_dependency 'fakeweb', '~> 1.3'
  gem.add_development_dependency 'rake', '~> 11.2', '>= 11.2.2'
  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'simplecov', '~> 0.12.0'
end
