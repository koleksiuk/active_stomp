# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_stomp/version'

Gem::Specification.new do |spec|
  spec.name          = "active_stomp"
  spec.version       = ActiveStomp::VERSION
  spec.authors       = ["Konrad Oleksiuk"]
  spec.email         = ["konrad@up-next.com"]
  spec.description   = %q{ActiveStomp allows to abstract the Stomp protocol}
  spec.homepage      = "https://github.com/koleksiuk/active_stomp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'shoulda'

  spec.add_dependency 'stomp'
end
