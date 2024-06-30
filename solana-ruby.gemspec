# frozen_string_literal: true

require_relative "lib/solana-ruby/version"

Gem::Specification.new do |spec|
    spec.name          = "solana-ruby"
    spec.version       = Solana::VERSION
    spec.authors       = ["Fabrice Renard"]
    spec.email         = ["fabrice.renard12@outlook.com"]

    spec.summary       = %q{A Ruby SDK for the Solana blockchain API}
    spec.description   = %q{Provides an easy-to-use interface for interacting with the Solana blockchain.}
    spec.homepage      = "https://github.com/fabricerenard12/solana-ruby"
    spec.license       = "MIT"

    spec.files         = Dir["lib/**/*.rb"]
    spec.require_paths = ["lib"]
    spec.required_ruby_version = ">= 3.0"

    spec.metadata["homepage_uri"] = spec.homepage

    spec.add_dependency "faraday", "~> 2.9.2"
    spec.add_dependency "faye-websocket", "~> 1.2.10"
    spec.add_dependency "csv", "~> 3.1"
    spec.add_dependency "ed25519", "~> 1.3"
    spec.add_dependency "base58", "~> 0.2.3"
    spec.add_dependency "base64", "~> 0.2.0"
    spec.add_dependency "rdoc", "~> 6.7.0"
    spec.add_dependency "rqrcode", "~> 2.0"

    spec.add_development_dependency "rspec", "~> 3.10"
    spec.add_development_dependency "webmock", "~> 3.14"
  end
