Gem::Specification.new do |spec|
    spec.name          = "solana-ruby"
    spec.version       = "0.1.0"
    spec.authors       = ["Fabrice Renard"]
    spec.email         = ["fabrice.renard12@outlook.com"]
  
    spec.summary       = %q{A Ruby wrapper for the Solana blockchain API}
    spec.description   = %q{Provides an easy-to-use interface for interacting with the Solana blockchain.}
    spec.homepage      = "https://github.com/fabricerenard12/solana.rb"
    spec.license       = "MIT"
  
    spec.files         = Dir["lib/**/*.rb"]
    spec.require_paths = ["lib"]
  
    spec.add_dependency "httparty"
  
    spec.add_development_dependency "rspec"
  end
  