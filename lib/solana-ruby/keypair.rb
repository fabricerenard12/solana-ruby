require 'rbnacl'
require 'base58'
require 'json'
require_relative 'client'
require_relative 'utils'

module SolanaRB
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
    # Saves the keypair to a JSON file.
    #
    # The public and secret keys are encoded in Base58 format before being saved.
    #
    # @param [String] file_path The path to the file where the keypair will be saved.
    def save_to_json(file_path)
      data = {
        public_key: Base58.binary_to_base58(@public_key, :bitcoin),
        secret_key: Base58.binary_to_base58(@secret_key, :bitcoin)
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
      secret_key = Base58.base58_to_binary(data[:secret_key], :bitcoin)
      public_key = Base58.base58_to_binary(data[:public_key], :bitcoin)

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
      Base58.binary_to_base58(@public_key, :bitcoin)
    end

    ##
    # Returns the raw secret key for this keypair in Base58 format.
    #
    # @return [String] The secret key in Base58 format.
    def secret_key_base58
      Base58.binary_to_base58(@secret_key, :bitcoin)
    end
  end
end

# # Example usage
# # Generate a new keypair
# secret_key = SolanaRB::Utils.base58_decode("3CX5EZdnR1KB7YRzpumAXgjtA1sbmo2h7bJbL8sY8NTnb17a7PwnYaHrXXvqZdLWqgeqBJTKHkC4ioCG2TiQMAzY")
# keypair = SolanaRB::Keypair.new(secret_key)
# puts "Public Key: #{keypair.public_key_base58}"
# puts "Secret Key: #{keypair.secret_key_base58}"

# # Save to JSON
# keypair.save_to_json('wallet.json')

# # Load from JSON
# loaded_keypair = SolanaRB::Keypair.load_from_json('wallet.json')
# puts "Loaded Public Key: #{loaded_keypair.public_key_base58}"
# puts "Loaded Secret Key: #{loaded_keypair.secret_key_base58}"

# # Get balance of wallet
# client = SolanaRB::Client.new
# balance = client.get_balance(loaded_keypair.public_key_base58)
# puts balance
