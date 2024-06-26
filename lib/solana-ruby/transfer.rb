require 'rbnacl'
require 'base58'
require_relative 'client'
require_relative 'instruction'
require_relative 'keypair'
require_relative 'utils'

# {
#   "message": {
#     "header": {
#       "numReadonlySignedAccounts": 0,
#       "numReadonlyUnsignedAccounts": 1,
#       "numRequiredSignatures": 1
#     },
#     "accountKeys": [
#       "3z9vL1zjN6qyAFHhHQdWYRTFAcy69pJydkZmSFBKHg1R",
#       "5snoUseZG8s8CDFHrXY2ZHaCrJYsW457piktDmhyb5Jd",
#       "11111111111111111111111111111111"
#     ],
#     "recentBlockhash": "DzfXchZJoLMG3cNftcf2sw7qatkkuwQf4xH15N5wkKAb",
#     "instructions": [
#       {
#         "accounts": [0, 1],
#         "data": "3Bxs4NN8M2Yn4TLb",
#         "programIdIndex": 2
#       }
#     ],
#     "indexToProgramIds": {}
#   },
#   "signatures": [
#     "5LrcE2f6uvydKRquEJ8xp19heGxSvqsVbcqUeFoiWbXe8JNip7ftPQNTAVPyTK7ijVdpkzmKKaAQR7MWMmujAhXD"
#   ]
# }

require_relative 'client'
require_relative 'utils'
require 'base58'
require 'rbnacl'

module SolanaRB
  class Transfer
    def initialize(from_pubkey, from_private_key, to_pubkey, sol_amount)
      @header = [0, 1, 1].pack('C*')
      @accounts = encode_compact_array([from_pubkey, to_pubkey, SolanaRB::Utils::SYSTEM_PROGRAM_ID])
      @recent_blockhash = Base58.base58_to_binary(SolanaRB::Client.new.get_latest_blockhash['value']['blockhash'], :bitcoin)
      @instruction = encode_instruction(2, [0, 1], '3Bxs4NN8M2Yn4TLb'.bytes.pack('C*'))
      @from_private_key = from_private_key
      @message = @header + @accounts + @recent_blockhash + @instruction
    end

    def serialize
      serialized_message = @message + sign
      Base58.binary_to_base58(serialized_message)
    end

    def encode_compact_array(array)
      length = array.length
      compact_length = length < 0xfd ? [length].pack('C') : [0xfd, length].pack('CS<')
      items = array.join.unpack('H*').first
      compact_length + items
    end

    def encode_instruction(program_id_index, account_indices, instruction_data)
      # Ensure program_id_index and account_indices are arrays
      program_id_index = [program_id_index].pack('C') # pack as compact-u8
      account_indices = encode_compact_array_indices(account_indices) # pack as compact array of u8 indices
      data_length = instruction_data.bytesize
      data_length_encoded = [data_length].pack('S<') # pack as compact-u16
      instruction_data_encoded = instruction_data.b # pack as opaque u8 data
      program_id_index + account_indices + data_length_encoded + instruction_data_encoded
    end

    # Function to encode an array into compact format
    def encode_compact_array_indices(array)
      length = array.length
      compact_length = length < 0xfd ? [length].pack('C') : [0xfd, length].pack('CS<')
      items = array.pack('C*')
      compact_length + items
    end

    def sign()
      secret_key = Base58.base58_to_binary(@from_private_key)
      signing_key = RbNaCl::SigningKey.new(secret_key[0, 32])
      signature = signing_key.sign(@message)
      signature
    end


  end
end

transfer = SolanaRB::Transfer.new(
  '2pBAG8SVebFVqKe5vy6pBsXbsqjojirjjqw841pg5MHW',
  "3CX5EZdnR1KB7YRzpumAXgjtA1sbmo2h7bJbL8sY8NTnb17a7PwnYaHrXXvqZdLWqgeqBJTKHkC4ioCG2TiQMAzY",
  '2KawHtjw47nPvVbqPG4R2jkS44hYrLu3zNFB9nQx77dP',
  0.01
)
serialized = transfer.serialize
client = SolanaRB::Client.new
puts serialized
client.send_transaction(serialized)
