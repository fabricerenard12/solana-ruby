require 'http'
require 'json'
require 'rbnacl'
require 'base64'
require 'base58'

class SolanaClient
  SOLANA_RPC_URL = "https://api.mainnet-beta.solana.com"

  def initialize
    @rpc_url = SOLANA_RPC_URL
  end

  def get_recent_blockhash
    response = HTTP.post(@rpc_url, json: { "jsonrpc": "2.0", "id": 1, "method": "getRecentBlockhash" })
    JSON.parse(response.body.to_s)["result"]["value"]["blockhash"]
  end

  def create_transaction(from, to, amount, blockhash)
    {
      "recentBlockhash" => blockhash,
      "feePayer" => from,
      "instructions" => [
        {
          "keys" => [
            { "pubkey" => from, "isSigner" => true, "isWritable" => true },
            { "pubkey" => to, "isSigner" => false, "isWritable" => true }
          ],
          "programId" => "11111111111111111111111111111111",
          "data" => Base64.strict_encode64([amount].pack("Q<"))
        }
      ],
      "signatures" => []
    }
  end

  def send_transaction(transaction, private_key)
    signed_transaction = sign_transaction(transaction, private_key)
    response = HTTP.post(@rpc_url, json: { "jsonrpc": "2.0", "id": 1, "method": "sendTransaction", "params": [Base64.strict_encode64(signed_transaction), { "encoding" => "base64" }] })
    JSON.parse(response.body.to_s)
  end

  def sign_transaction(transaction, private_key)
    # Deserialize the private key
    private_key_bytes = Base58.base58_to_binary(private_key, :bitcoin)

    # Ensure the private key is 32 bytes long
    private_key_bytes = private_key_bytes[0, 32]

    # Serialize the transaction
    serialized_tx = serialize_transaction(transaction)

    # Sign the transaction
    signing_key = RbNaCl::Signatures::Ed25519::SigningKey.new(private_key_bytes)
    signature = signing_key.sign(serialized_tx)

    # Attach the signature to the transaction
    transaction["signatures"] = [Base58.binary_to_base58(signature, :bitcoin)]
    serialize_transaction(transaction)
  end

  def serialize_transaction(transaction)
    # Convert base58 addresses to binary
    fee_payer = Base58.base58_to_binary(transaction["feePayer"], :bitcoin)
    recent_blockhash = Base58.base58_to_binary(transaction["recentBlockhash"], :bitcoin)

    # Serialize instructions
    serialized_instructions = transaction["instructions"].map do |instruction|
      keys = instruction["keys"].map do |key|
        key_bytes = Base58.base58_to_binary(key["pubkey"], :bitcoin)
        is_signer = key["isSigner"] ? 1 : 0
        is_writable = key["isWritable"] ? 1 : 0
        [key_bytes, is_signer, is_writable].pack("a32CC")
      end.join

      program_id = Base58.base58_to_binary(instruction["programId"], :bitcoin)
      data = Base64.strict_decode64(instruction["data"])

      [keys, program_id, data].pack("a*a*a*")
    end.join

    # Combine all parts of the transaction into a single buffer
    serialized_tx = [fee_payer, recent_blockhash, serialized_instructions].join

    # Ensure the transaction buffer is correctly filled
    serialized_tx
  end
end
