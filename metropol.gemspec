
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "metropol/version"

Gem::Specification.new do |spec|
  spec.name          = "metropol"
  spec.version       = Metropol::VERSION
  spec.authors       = ["Alkarim Lalani"]
  spec.email         = ["alkarim.lalani@gmail.com"]

  spec.summary       = 'A Ruby interface to the Metropol Credit Reference ' \
                       'Bureau API'
  spec.description   = 'Metropol is a Kenyan Credit Reference Bureau (CRB). ' \
                       'This Ruby library provides a simple interface to ' \
                       'their API'
  spec.homepage      = "https://github.com/alkarimlalani/metropol"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
