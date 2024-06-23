Gem::Specification.new do |spec|
    spec.name          = "solana-ruby"
    spec.version       = "0.1.0"
    spec.authors       = ["Fabrice Renard"]
    spec.email         = ["fabrice.renard12@outlook.com"]
  
    spec.summary       = %q{A Ruby wrapper for the Solana blockchain API}
    spec.description   = %q{Provides an easy-to-use interface for interacting with the Solana blockchain.}
    spec.homepage      = "https://github.com/fabricerenard12/solana-ruby"
    spec.license       = "MIT"
  
    spec.files         = Dir["lib/**/*.rb"]
    spec.require_paths = ["lib"]
    spec.required_ruby_version = ">= 3.0"
  
    spec.add_dependency "httparty", "~> 0.18.0"
    spec.add_dependency "csv", "~> 3.1"

    spec.add_development_dependency "rspec", "~> 3.10"
    spec.add_development_dependency "webmock", "~> 3.14"
  end
  