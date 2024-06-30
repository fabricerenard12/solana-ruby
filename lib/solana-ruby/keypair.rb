require 'rbnacl'
require 'json'
require_relative 'utils'

module Solana
  ##
  # The Keypair class represents a keypair for signing transactions on the Solana blockchain.
  #
  class Keypair
    attr_reader :public_key, :secret_key

    ##
    # Initializes a new Keypair.
    #
    # If a +secret_key+ is provided, it must be 64 bytes long. The first 32 bytes are used as the signing key,
    # and the public key is derived from it. If no +secret_key+ is provided, a new keypair is generated.
    #
    # Raises an error if the +secret_key+ is not 64 bytes long.
    #
    # @param [String, nil] secret_key The secret key to use for the keypair, in binary format (optional).
    def initialize(secret_key = nil)
      if secret_key
        raise 'Bad secret key size' unless secret_key.bytesize == 64
        @signing_key = RbNaCl::Signatures::Ed25519::SigningKey.new(secret_key[0, 32])
        @public_key = @signing_key.verify_key.to_bytes
      else
        @signing_key = RbNaCl::Signatures::Ed25519::SigningKey.generate
        @public_key = @signing_key.verify_key.to_bytes
      end
      @secret_key = @signing_key.to_bytes + @public_key
    end

    ##
    # Generates a new Keypair.
    #
    # @return [Keypair] A new Keypair instance.
    def self.generate
      new
    end

    ##
    # Creates a Keypair from a provided secret key.
    #
    # @param [String] secret_key The secret key in binary format.
    # @return [Keypair] A new Keypair instance initialized with the provided secret key.
    def self.from_secret_key(secret_key)
      new(secret_key)
    end

    ##
    # Saves the keypair to a JSON file.
    #
    # The public and secret keys are encoded in Base58 format before being saved.
    #
    # @param [String] file_path The path to the file where the keypair will be saved.
    def save_to_json(file_path)
      data = {
        public_key: Utils::base58_encode(@public_key),
        secret_key: Utils::base58_encode(@secret_key)
      }
      File.write(file_path, data.to_json)
    end

    ##
    # Loads a keypair from a JSON file.
    #
    # The file must contain the public and secret keys in Base58 format. The method verifies the size of the secret key and
    # checks that the derived public key matches the saved public key.
    #
    # Raises an error if the +secret_key+ is not 64 bytes long or if the derived public key does not match the saved public key.
    #
    # @param [String] file_path The path to the file from which the keypair will be loaded.
    # @return [Keypair] The loaded keypair.
    def self.load_from_json(file_path)
      data = JSON.parse(File.read(file_path), symbolize_names: true)
      secret_key = Utils::base58_decode(data[:secret_key])
      public_key = Utils::base58_decode(data[:public_key])

      raise 'Bad secret key size' unless secret_key.bytesize == 64

      signing_key = RbNaCl::Signatures::Ed25519::SigningKey.new(secret_key[0, 32])
      loaded_public_key = signing_key.verify_key.to_bytes

      raise 'Provided secretKey is invalid' unless loaded_public_key == public_key

      new(secret_key)
    end

    ##
    # Returns the public key for this keypair in Base58 format.
    #
    # @return [String] The public key in Base58 format.
    def public_key_base58
      Utils::base58_encode(@public_key)
    end

    ##
    # Returns the raw secret key for this keypair in Base58 format.
    #
    # @return [String] The secret key in Base58 format.
    def secret_key_base58
      Utils::base58_encode(@secret_key)
    end
  end
end
