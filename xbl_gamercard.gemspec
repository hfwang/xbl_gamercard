# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xbl_gamercard/version'

Gem::Specification.new do |spec|
  spec.name          = "xbl_gamercard"
  spec.version       = XblGamercard::VERSION
  spec.authors       = ["Hsiu-Fan Wang"]
  spec.email         = ["hfwang@porkbuns.net"]
  spec.summary       = %q{XBox Live gamercard and Live profile scraper}
  spec.description   = %q{A Nokogiri based XBox Live gamercard and Live profile scraper}
  spec.homepage      = "https://github.com/hfwang/xbl_gamercard"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  if RUBY_VERSION < "1.9"
    spec.add_dependency "nokogiri", "~> 1.5.9"
  else
    spec.add_dependency "nokogiri", "~> 1.0"
  end

  spec.add_development_dependency "rspec", "~> 2.4"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "vcr", "~> 2.8"
  spec.add_development_dependency "webmock", "~> 1.15.0"
  spec.add_development_dependency "rake"
end
