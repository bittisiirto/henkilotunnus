# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hetu/version'

Gem::Specification.new do |spec|
  spec.name          = 'hetu'
  spec.version       = Hetu::VERSION
  spec.authors       = ['Alexander Hanhikoski']
  spec.email         = ['alexander.hanhikoski@gmail.com']
  # spec.description   = %q{TODO: Write a gem description}
  spec.summary       = 'Validates Finnish personal identification numbers (henkilötunnus)'
  spec.homepage      = 'https://github.com/alexhanh/hetu'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'activemodel'
  spec.add_development_dependency 'timecop'
end
