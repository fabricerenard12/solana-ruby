require 'rbnacl'
require 'base58'
require_relative 'client'
require_relative 'utils'

module SolanaRB
  class Transfer
    def initialize(from_pubkey, from_private_key, to_pubkey, sol_amount)
      @from_pubkey = from_pubkey
      @from_private_key = from_private_key
      @to_pubkey = to_pubkey
      @sol_amount = sol_amount
      @recent_blockhash = fetch_recent_blockhash
      @header = [1, 0, 2].pack('C*') # 1 required signature, 0 read-only signed accounts, 2 read-only unsigned accounts
      @accounts = encode_account_keys([@from_pubkey, @to_pubkey, SolanaRB::Utils::SYSTEM_PROGRAM_ID])
      @instruction = encode_instruction(2, [0, 1], encode_transfer_data(@sol_amount))
      @message = @header + @accounts + @recent_blockhash + @instruction
    end

    def serialize(require_all_signatures: true, verify_signatures: true)
      sign_data = @message
      if verify_signatures
        sig_errors = verify_signatures(sign_data, require_all_signatures)
        raise sig_errors if sig_errors
      end

      _serialize(sign_data)
    end

    private

    def fetch_recent_blockhash
      blockhash = SolanaRB::Client.new.get_latest_blockhash['value']['blockhash']
      Base58.base58_to_binary(blockhash, :bitcoin)
    end

    def encode_account_keys(account_keys)
      length = encode_length(account_keys.length)
      encoded_keys = account_keys.map { |key| Base58.base58_to_binary(key) }.join
      length + encoded_keys
    end

    def encode_instruction(program_id_index, account_indices, instruction_data)
      program_id_index = [program_id_index].pack('C')
      account_indices = encode_length(account_indices.length) + account_indices.pack('C*')
      data_length = encode_length(instruction_data.bytesize)
      program_id_index + account_indices + data_length + instruction_data
    end

    def encode_length(value)
      if value < 0xfd
        [value].pack('C')
      elsif value <= 0xffff
        [0xfd, value].pack('CS<')
      elsif value <= 0xffffffff
        [0xfe, value].pack('CL<')
      else
        [0xff, value].pack('CQ<')
      end
    end

    def encode_transfer_data(sol_amount)
      lamports = (sol_amount * 1_000_000_000).to_i
      [lamports].pack('Q<')
    end

    def sign_message
      secret_key = Base58.base58_to_binary(@from_private_key)
      signing_key = RbNaCl::SigningKey.new(secret_key[0, 32])
      signing_key.sign(@message)
    end

    def verify_signatures(sign_data, require_all_signatures)
      signatures = [sign_message]
      invalid_sigs = []
      missing_sigs = []

      if signatures.empty? || (require_all_signatures && signatures.include?(nil))
        missing_sigs << @from_pubkey
      else
        signatures.each do |sig|
          if sig.nil? || sig.length != 64
            invalid_sigs << @from_pubkey
          end
        end
      end

      return if invalid_sigs.empty? && missing_sigs.empty?

      error_message = "Signature verification failed."
      error_message += "\nInvalid signature for public key(s) [#{invalid_sigs.join(', ')}]." unless invalid_sigs.empty?
      error_message += "\nMissing signature for public key(s) [#{missing_sigs.join(', ')}]." unless missing_sigs.empty?
      error_message
    end

    def _serialize(sign_data)
      signatures = [sign_message]
      signature_count = encode_length(signatures.length)
      transaction_length = signature_count.bytesize + signatures.length * 64 + sign_data.bytesize
      wire_transaction = signature_count + signatures.pack('a64') + sign_data

      raise "Transaction too large: #{wire_transaction.length} > #{PACKET_DATA_SIZE}" if wire_transaction.length > PACKET_DATA_SIZE

      wire_transaction
    end
  end
end

# Example usage
transfer = SolanaRB::Transfer.new(
  '2pBAG8SVebFVqKe5vy6pBsXbsqjojirjjqw841pg5MHW',
  '3CX5EZdnR1KB7YRzpumAXgjtA1sbmo2h7bJbL8sY8NTnb17a7PwnYaHrXXvqZdLWqgeqBJTKHkC4ioCG2TiQMAzY',
  '2KawHtjw47nPvVbqPG4R2jkS44hYrLu3zNFB9nQx77dP',
  0.01
)
serialized = transfer.serialize
client = SolanaRB::Client.new
puts serialized.unpack('H*').first # This will print the hex string for debugging
response = client.simulate_transaction(Base58.binary_to_base58(serialized))
puts response
