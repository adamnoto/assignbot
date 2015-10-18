# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'assignbot/version'

Gem::Specification.new do |spec|
  spec.name          = 'assignbot'
  spec.version       = Assignbot::VERSION
  spec.authors       = ['Adam Pahlevi']
  spec.email         = ['adam.pahlevi@gmail.com']

  spec.summary       = 'Automatical object assignment using hash'
  spec.description   = "Assign an object's instance variables using hash"
  spec.homepage      = 'https://github.com/saveav/assignbot'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
end
