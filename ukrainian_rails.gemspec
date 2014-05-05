# -*- encoding: utf-8 -*-

$: << File.expand_path('../lib', __FILE__)
require 'ukrainian/version'

Gem::Specification.new do |spec|
  spec.name          = "ukrainian_rails"
  spec.version          = "0.0.1"
  spec.authors       = ["glebtv", "Yaroslav Markin"]
  spec.email         = ["glebtv@gmail.com", "yaroslav@markin.net"]
  spec.description   = %q{Ukrainian language support for Ruby and Rails}
  spec.summary       = %q{Ukrainian language support for Ruby and Rails}
  spec.homepage      = "https://github.com/blasterun/ukrainian_rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'i18n', '~> 0.6.0'
  spec.add_dependency 'unicode', '~> 0.4.4'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'activesupport', '>= 3.0.0'
end
