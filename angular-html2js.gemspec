# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'angular/html2js/version'

Gem::Specification.new do |spec|
  spec.name          = "angular-html2js"
  spec.version       = Angular::Html2js::VERSION
  spec.authors       = ["Nicholas Clark"]
  spec.email         = ["nick.clark@k3integrations.com"]
  spec.description   = %q{Angular HTML2JS allows you to use ng templates as first class citezens in the Rails/Sprockets world. Based on the karma-ng-html2js-preprocessor for Karma.}
  spec.summary       = %q{AngularJS HTML templates in Sprockets and Rails}
  spec.homepage      = "http://www.k3integrations.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "tilt", "~> 1.0"
  spec.add_dependency "sprockets", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.12"
  spec.add_development_dependency "rake"
end
