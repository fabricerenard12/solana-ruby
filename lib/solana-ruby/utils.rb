require 'base58'
require 'base64'

module SolanaRB
  module Utils
    SYSTEM_PROGRAM_ID = '11111111111111111111111111111111'.freeze
    MAINNET = 'https://api.mainnet-beta.solana.com'.freeze
    DEVNET = 'https://api.devnet.solana.com'.freeze
    TESTNET = 'https://api.testnet.solana.com'.freeze
    PACKET_DATA_SIZE = 1232

    def self.base58_encode(bytes)
      Base58.binary_to_base58(bytes, :bitcoin)
    end

    def self.base58_decode(base58)
      Base58.base58_to_binary(base58, :bitcoin)
    end

    def self.base64_encode(bytes)
      Base64.strict_encode64(bytes)
    end

    def self.base64_decode(base64)
      Base64.strict_decode64(base64)
    end

    def self.pack_u8(value)
      [value].pack('C')
    end

    def self.pack_u16(value)
      [value].pack('v')
    end

    def self.pack_u32(value)
      [value].pack('V')
    end

    def self.pack_i64(value)
      [value].pack('q<')
    end

    def self.pack_pubkey(pubkey)
      base58_decode(pubkey)
    end
  end
end
