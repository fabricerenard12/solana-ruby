require 'base58'
require 'base64'

module SolanaRB
  ##
  # The Utils module provides utility methods and constants for interacting with the Solana blockchain.
  #
  module Utils
    ##
    # The system program ID for Solana.
    SYSTEM_PROGRAM_ID = '11111111111111111111111111111111'

    ##
    # The maximum packet data size for Solana transactions.
    PACKET_DATA_SIZE = 1232

    ##
    # Endpoints for the mainnet.
    module MAINNET
      ##
      # HTTP endpoint for the mainnet.
      HTTP = 'https://api.mainnet-beta.solana.com'

      ##
      # WebSocket endpoint for the mainnet.
      WS = 'wss://api.mainnet-beta.solana.com'
    end

    ##
    # Endpoints for the testnet.
    module TESTNET
      ##
      # HTTP endpoint for the testnet.
      HTTP = 'https://api.testnet.solana.com'

      ##
      # WebSocket endpoint for the testnet.
      WS = 'wss://api.testnet.solana.com'
    end

    ##
    # Endpoints for the devnet.
    module DEVNET
      ##
      # HTTP endpoint for the devnet.
      HTTP = 'https://api.devnet.solana.com'

      ##
      # WebSocket endpoint for the devnet.
      WS = 'wss://api.devnet.solana.com'
    end

    ##
    # Instruction types for Solana transactions.
    module InstructionType
      CREATE_ACCOUNT = 0
      ASSIGN = 1
      TRANSFER = 2
      CREATE_ACCOUNT_WITH_SEED = 3
      ADVANCE_NONCE_ACCOUNT = 4
      WITHDRAW_NONCE_ACCOUNT = 5
      INITIALIZE_NONCE_ACCOUNT = 6
      AUTHORIZE_NONCE_ACCOUNT = 7
      ALLOCATE = 8
      ALLOCATE_WITH_SEED = 9
      ASSIGN_WITH_SEED = 10
      TRANSFER_WITH_SEED = 11
    end

    ##
    # Encodes a byte array into a Base58 string.
    #
    # @param [String] bytes The byte array to encode.
    # @return [String] The Base58-encoded string.
    def self.base58_encode(bytes)
      Base58.binary_to_base58(bytes, :bitcoin)
    end

    ##
    # Decodes a Base58 string into a byte array.
    #
    # @param [String] base58 The Base58 string to decode.
    # @return [String] The decoded byte array.
    def self.base58_decode(base58)
      Base58.base58_to_binary(base58, :bitcoin)
    end

    ##
    # Encodes a byte array into a Base64 string.
    #
    # @param [String] bytes The byte array to encode.
    # @return [String] The Base64-encoded string.
    def self.base64_encode(bytes)
      Base64.strict_encode64(bytes)
    end

    ##
    # Decodes a Base64 string into a byte array.
    #
    # @param [String] base64 The Base64 string to decode.
    # @return [String] The decoded byte array.
    def self.base64_decode(base64)
      Base64.strict_decode64(base64)
    end
  end
  Utils.freeze
end
