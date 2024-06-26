require 'httparty'

module SolanaRB
  ##
  # Client class for interacting with the Solana JSON RPC API.
  class Client
    include HTTParty
    base_uri 'https://api.testnet.solana.com'

    ##
    # Initializes a new Client.
    #
    # @param [String, nil] api_key Optional API key for authentication.
    def initialize(api_key = nil)
      @api_key = api_key
    end

    ##
    # Retrieves account information for a given public key.
    #
    # @param [String] pubkey The public key of the account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The account information.
    def get_account_info(pubkey, options = {})
      request('getAccountInfo', [pubkey, options])
    end

    ##
    # Retrieves the balance for a given public key.
    #
    # @param [String] pubkey The public key of the account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The balance in lamports.
    def get_balance(pubkey, options = {})
      request('getBalance', [pubkey, options])
    end

    ##
    # Retrieves information about a specific block.
    #
    # @param [Integer] slot_number The slot number of the block.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The block information.
    def get_block(slot_number, options = {})
      request('getBlock', [slot_number, options])
    end

    ##
    # Retrieves block commitment information for a specific block.
    #
    # @param [Integer] slot_number The slot number of the block.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The block commitment information.
    def get_block_commitment(slot_number, options = {})
      request('getBlockCommitment', [slot_number, options])
    end

    ##
    # Retrieves the current block height.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The current block height.
    def get_block_height(options = {})
      request('getBlockHeight', [options])
    end

    ##
    # Retrieves block production information.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The block production information.
    def get_block_production(options = {})
      request('getBlockProduction', [options])
    end

    ##
    # Retrieves the estimated production time of a specific block.
    #
    # @param [Integer] slot_number The slot number of the block.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The estimated production time in seconds.
    def get_block_time(slot_number, options = {})
      request('getBlockTime', [slot_number, options])
    end

    ##
    # Retrieves a list of confirmed blocks between two slot numbers.
    #
    # @param [Integer] start_slot The start slot number.
    # @param [Integer] end_slot The end slot number.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Integer>] The list of confirmed blocks.
    def get_blocks(start_slot, end_slot, options = {})
      request('getBlocks', [start_slot, end_slot, options])
    end

    ##
    # Retrieves a list of confirmed blocks starting from a given slot number with a limit on the number of blocks.
    #
    # @param [Integer] start_slot The start slot number.
    # @param [Integer] limit The maximum number of blocks to return.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Integer>] The list of confirmed blocks.
    def get_blocks_with_limit(start_slot, limit, options = {})
      request('getBlocksWithLimit', [start_slot, limit, options])
    end

    ##
    # Retrieves the list of cluster nodes.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The list of cluster nodes.
    def get_cluster_nodes(options = {})
      request('getClusterNodes', [options])
    end

    ##
    # Retrieves epoch information.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The epoch information.
    def get_epoch_info(options = {})
      request('getEpochInfo', [options])
    end

    ##
    # Retrieves the epoch schedule.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The epoch schedule.
    def get_epoch_schedule(options = {})
      request('getEpochSchedule', [options])
    end

    ##
    # Retrieves the fee for a given message.
    #
    # @param [String] message The message for which the fee is to be calculated.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The fee for the message.
    def get_fee_for_message(message, options = {})
      request('getFeeForMessage', [message, options])
    end

    ##
    # Retrieves the slot of the first available block.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The slot of the first available block.
    def get_first_available_block(options = {})
      request('getFirstAvailableBlock', [options])
    end

    ##
    # Retrieves the genesis hash.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [String] The genesis hash.
    def get_genesis_hash(options = {})
      request('getGenesisHash', [options])
    end

    ##
    # Checks the health of the node.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [String] The health status of the node.
    def get_health(options = {})
      request('getHealth', [options])
    end

    ##
    # Retrieves the highest snapshot slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The highest snapshot slot.
    def get_highest_snapshot_slot(options = {})
      request('getHighestSnapshotSlot', [options])
    end

    ##
    # Retrieves the identity of the node.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The identity information of the node.
    def get_identity(options = {})
      request('getIdentity', [options])
    end

    ##
    # Retrieves the current inflation governor settings.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The inflation governor settings.
    def get_inflation_governor(options = {})
      request('getInflationGovernor', [options])
    end

    ##
    # Retrieves the current inflation rate.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The inflation rate.
    def get_inflation_rate(options = {})
      request('getInflationRate', [options])
    end

    ##
    # Retrieves the inflation reward for a given list of addresses.
    #
    # @param [Array<String>] addresses The list of addresses.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The inflation rewards for the addresses.
    def get_inflation_reward(addresses, options = {})
      request('getInflationReward', [addresses, options])
    end

    ##
    # Retrieves the largest accounts.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The largest accounts.
    def get_largest_accounts(options = {})
      request('getLargestAccounts', [options])
    end

    ##
    # Retrieves the latest blockhash.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The latest blockhash.
    def get_latest_blockhash(options = {})
      request('getLatestBlockhash', [options])
    end

    ##
    # Retrieves the leader schedule.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The leader schedule.
    def get_leader_schedule(options = {})
      request('getLeaderSchedule', [options])
    end

    ##
    # Retrieves the maximum retransmit slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The maximum retransmit slot.
    def get_max_retransmit_slot(options = {})
      request('getMaxRetransmitSlot', [options])
    end

    ##
    # Retrieves the maximum shred insert slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The maximum shred insert slot.
    def get_max_shred_insert_slot(options = {})
      request('getMaxShredInsertSlot', [options])
    end

    ##
    # Retrieves the minimum balance required for rent exemption for a given data length.
    #
    # @param [Integer] data_length The length of the data in bytes.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The minimum balance for rent exemption.
    def get_minimum_balance_for_rent_exemption(data_length, options = {})
      request('getMinimumBalanceForRentExemption', [data_length, options])
    end

    ##
    # Retrieves information for multiple accounts.
    #
    # @param [Array<String>] pubkeys The list of public keys.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The information for the accounts.
    def get_multiple_accounts(pubkeys, options = {})
      request('getMultipleAccounts', [pubkeys, options])
    end

    ##
    # Retrieves information for accounts owned by a specific program.
    #
    # @param [String] pubkey The public key of the program.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The information for the program accounts.
    def get_program_accounts(pubkey, options = {})
      request('getProgramAccounts', [pubkey, options])
    end

    ##
    # Retrieves recent performance samples.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The recent performance samples.
    def get_recent_performance_samples(options = {})
      request('getRecentPerformanceSamples', [options])
    end

    ##
    # Retrieves recent prioritization fees.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The recent prioritization fees.
    def get_recent_prioritization_fees(options = {})
      request('getRecentPrioritizationFees', [options])
    end

    ##
    # Retrieves the status of given transaction signatures.
    #
    # @param [Array<String>] signatures The list of transaction signatures.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The status of the transaction signatures.
    def get_signature_statuses(signatures, options = {})
      request('getSignatureStatuses', [signatures, options])
    end

    ##
    # Retrieves the signatures for a given address.
    #
    # @param [String] address The address for which to retrieve signatures.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The signatures for the address.
    def get_signatures_for_address(address, options = {})
      request('getSignaturesForAddress', [address, options])
    end

    ##
    # Retrieves the current slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The current slot.
    def get_slot(options = {})
      request('getSlot', [options])
    end

    ##
    # Retrieves the current slot leader.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [String] The current slot leader.
    def get_slot_leader(options = {})
      request('getSlotLeader', [options])
    end

    ##
    # Retrieves the slot leaders starting from a given slot with a limit on the number of leaders.
    #
    # @param [Integer] start_slot The start slot number.
    # @param [Integer] limit The maximum number of leaders to return.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<String>] The slot leaders.
    def get_slot_leaders(start_slot, limit, options = {})
      request('getSlotLeaders', [start_slot, limit, options])
    end

    ##
    # Retrieves the stake activation information for a given public key.
    #
    # @param [String] pubkey The public key of the stake account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The stake activation information.
    def get_stake_activation(pubkey, options = {})
      request('getStakeActivation', [pubkey, options])
    end

    ##
    # Retrieves the minimum delegation for a stake account.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The minimum delegation.
    def get_stake_minimum_delegation(options = {})
      request('getStakeMinimumDelegation', [options])
    end

    ##
    # Retrieves the supply information.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The supply information.
    def get_supply(options = {})
      request('getSupply', [options])
    end

    ##
    # Retrieves the token balance for a given token account.
    #
    # @param [String] pubkey The public key of the token account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The token balance.
    def get_token_account_balance(pubkey, options = {})
      request('getTokenAccountBalance', [pubkey, options])
    end

    ##
    # Retrieves token accounts by delegate.
    #
    # @param [String] delegate The delegate address.
    # @param [Hash] opts Additional options for the request.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The token accounts by delegate.
    def get_token_accounts_by_delegate(delegate, opts = {}, options = {})
      request('getTokenAccountsByDelegate', [delegate, opts, options])
    end

    ##
    # Retrieves token accounts by owner.
    #
    # @param [String] owner The owner address.
    # @param [Hash] opts Additional options for the request.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The token accounts by owner.
    def get_token_accounts_by_owner(owner, opts = {}, options = {})
      request('getTokenAccountsByOwner', [owner, opts, options])
    end

    ##
    # Retrieves the largest accounts for a given token.
    #
    # @param [String] pubkey The public key of the token.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The largest accounts for the token.
    def get_token_largest_accounts(pubkey, options = {})
      request('getTokenLargestAccounts', [pubkey, options])
    end

    ##
    # Retrieves the supply of a given token.
    #
    # @param [String] pubkey The public key of the token.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The token supply.
    def get_token_supply(pubkey, options = {})
      request('getTokenSupply', [pubkey, options])
    end

    ##
    # Retrieves transaction details for a given signature.
    #
    # @param [String] signature The transaction signature.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The transaction details.
    def get_transaction(signature, options = {})
      request('getTransaction', [signature, options])
    end

    ##
    # Retrieves the total number of transactions processed by the network.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The total number of transactions.
    def get_transaction_count(options = {})
      request('getTransactionCount', [options])
    end

    ##
    # Retrieves the current version of the Solana software.
    #
    # @return [Hash] The current version information.
    def get_version
      request('getVersion')
    end

    ##
    # Retrieves the list of vote accounts.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The list of vote accounts.
    def get_vote_accounts(options = {})
      request('getVoteAccounts', [options])
    end

    ##
    # Checks if a given blockhash is valid.
    #
    # @param [String] blockhash The blockhash to check.
    # @param [Hash] options Optional parameters for the request.
    # @return [Boolean] Whether the blockhash is valid.
    def is_blockhash_valid(blockhash, options = {})
      request('isBlockhashValid', [blockhash, options])
    end

    ##
    # Retrieves the minimum ledger slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The minimum ledger slot.
    def minimum_ledger_slot(options = {})
      request('minimumLedgerSlot', [options])
    end

    ##
    # Requests an airdrop to a given public key.
    #
    # @param [String] pubkey The public key to receive the airdrop.
    # @param [Integer] lamports The amount of lamports to airdrop.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The airdrop request response.
    def request_airdrop(pubkey, lamports, options = {})
      request('requestAirdrop', [pubkey, lamports, options])
    end

    ##
    # Sends a transaction.
    #
    # @param [Hash] transaction The transaction to send.
    # @return [Hash] The response from the send transaction request.
    def send_transaction(transaction)
      request('sendTransaction', [transaction.to_json])
    end

    ##
    # Simulates a transaction.
    #
    # @param [Hash] transaction The transaction to simulate.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The simulation response.
    def simulate_transaction(transaction, options = {})
      request('simulateTransaction', [transaction.to_json, options])
    end

    ##
    # Sends a JSON-RPC request to the Solana API.
    #
    # @param [String] method The RPC method to call.
    # @param [Array] params The parameters for the RPC method.
    # @return [Object] The parsed response from the API.
    def request(method, params = nil)
      body = {
        jsonrpc: '2.0',
        method: method,
        id: 1
      }
      body[:params] = params if params

      if method == "sendTransaction" ## TO REMOVE
        transaction_string = body[:params][0].delete('"')
        body[:params][0] = transaction_string
      end

      options = {
        headers: { 'Content-Type' => 'application/json' },
        body: body.to_json
      }

      puts body.to_json
      response = self.class.post('/', options)
      handle_response(response)
    end

    ##
    # Handles the API response, checking for success and parsing the result.
    #
    # @param [HTTParty::Response] response The HTTP response object.
    # @raise [RuntimeError] If the request fails (non-success response).
    # @return [Object] The parsed result from the API response.
    def handle_response(response)
      puts response.parsed_response
      if response.success?
        response.parsed_response['result']
      else
        raise "Request failed: #{response.code} #{response.message}"
      end
    end
  end
end
