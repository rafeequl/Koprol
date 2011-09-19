# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "koprol/version"

Gem::Specification.new do |s|
  s.name        = "koprol"
  s.version     = Koprol::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rafeequl"]
  s.email       = ["rafeequl@yahoo-inc.com"]
  s.homepage    = ""
  s.summary     = %q{Koprol API Ruby wrapper}
  s.description = %q{In attempt to make ActiveRecord style to access Koprol API}

  s.rubyforge_project = "koprol"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # Dependencies
  s.add_runtime_dependency(%q<net/http>)
  s.add_runtime_dependency(%q<json>, ["~> 1.5.0"])
  s.add_runtime_dependency(%q<oauth>, ["~> 0.4.0"])
end
