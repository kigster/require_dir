# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'require_dir/version'

Gem::Specification.new do |spec|
  spec.name          = 'require_dir'
  spec.version       = RequireDir::VERSION
  spec.authors       = ['Konstantin Gredeskoul']
  spec.email         = ['kig@reinvent.one']

  spec.summary       = %q{Easily and non-intrusively require files from sub-folders}
  spec.description   = %q{Easily and non-intrusively require files from sub-folders. Without polluting global namespace, or having modules clobber each other, include RequireDir and initialize it to get access to #dir and #dir_r}
  spec.homepage      = 'https://github.com/kigster/require_dir'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = %w(lib)

  spec.add_dependency 'colored2'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
end
