require 'json'

module SolanaRB
  # Represents a Solana instruction with keys, program ID, and data.
  class Instruction
    attr_accessor :keys, :program_id, :data

    # Initialize a new Instruction object.
    #
    # @param keys [Array<Hash>] Array of account keys for the instruction.
    #   Each Hash should contain :pubkey (String), :is_signer (Boolean), and :is_writable (Boolean).
    # @param program_id [String] Program ID for the instruction.
    # @param data [String] Data buffer for the instruction.
    def initialize(keys, program_id, data)
      @keys = keys
      @program_id = program_id
      @data = data
    end

    # Converts the Instruction object to a JSON representation.
    #
    # @return [String] JSON string representing the Instruction object.
    def to_json()
      {
        keys: @keys.map do |key|
          {
            pubkey: key[:pubkey],
            isSigner: key[:is_signer],
            isWritable: key[:is_writable]
          }
        end,
        programId: @program_id,
        data: @data.bytes
      }.to_json
    end
  end
end
