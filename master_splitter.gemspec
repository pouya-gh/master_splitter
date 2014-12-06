# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'master_splitter/version'

Gem::Specification.new do |spec|
  spec.name          = "master_splitter"
  spec.version       = MasterSplitter::VERSION
  spec.authors       = ["Pouya Gharib Pour"]
  spec.email         = ["p.gharibpour@gmail.com"]
  spec.summary       = %q{File spliter and joiner.}
  spec.description   = %q{Simple file spliter and joiner. But not compressor.}
  spec.homepage      = "github.com/psparabara/master_splitter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
