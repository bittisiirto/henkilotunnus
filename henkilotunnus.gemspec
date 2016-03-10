# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'henkilotunnus/version'

Gem::Specification.new do |spec|
  spec.name          = "henkilotunnus"
  spec.version       = Henkilotunnus::VERSION
  spec.authors       = ["Alexander Hanhikoski"]
  spec.email         = ["tech@pikasiirto.fi"]

  spec.summary       = %q{Validates Finnish personal identification numbers (henkilötunnus).}
  spec.homepage      = "https://github.com/bittisiirto/henkilotunnus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "timecop", "~> 0.8.0"

  spec.add_runtime_dependency "activemodel", "~> 4.2"
end
