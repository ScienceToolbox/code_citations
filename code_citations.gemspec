# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'code_citations/version'

Gem::Specification.new do |spec|
  spec.name          = "code_citations"
  spec.version       = CodeCitations::VERSION
  spec.authors       = ["Jure Triglav"]
  spec.email         = ["juretriglav@gmail.com"]
  spec.summary       = %q{Ruby gem for finding citations of open scientific software.}
  spec.description   = %q{Ruby gem uses various open APIs to find citations of open scientific software.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rinruby"
  spec.add_runtime_dependency "nokogiri"

  spec.add_development_dependency "pry"
  # Tests
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
