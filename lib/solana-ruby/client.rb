require 'httparty'

module SolanaRB
  class Client
    include HTTParty
    base_uri 'https://api.mainnet-beta.solana.com'

    def initialize(api_key = nil)
      @api_key = api_key
    end

    def get_account_info(pubkey, options = {})
      request('getAccountInfo', [pubkey, options])
    end

    def get_balance(pubkey, options = {})
      request('getBalance', [pubkey, options])
    end

    def get_block(slot_number, options = {})
      request('getBlock', [slot_number, options])
    end

    def get_block_commitment(slot_number, options = {})
      request('getBlockCommitment', [slot_number, options])
    end

    def get_block_height(options = {})
      request('getBlockHeight', [options])
    end

    def get_block_production(options = {})
      request('getBlockProduction', [options])
    end

    def get_block_time(slot_number, options = {})
      request('getBlockTime', [slot_number, options])
    end

    def get_blocks(start_slot, end_slot, options = {})
      request('getBlocks', [start_slot, end_slot, options])
    end

    def get_blocks_with_limit(start_slot, limit, options = {})
      request('getBlocksWithLimit', [start_slot, limit, options])
    end

    def get_cluster_nodes(options = {})
      request('getClusterNodes', [options])
    end

    def get_epoch_info(options = {})
      request('getEpochInfo', [options])
    end

    def get_epoch_schedule(options = {})
      request('getEpochSchedule', [options])
    end

    def get_fee_for_message(message, options = {})
      request('getFeeForMessage', [message, options])
    end

    def get_first_available_block(options = {})
      request('getFirstAvailableBlock', [options])
    end

    def get_genesis_hash(options = {})
      request('getGenesisHash', [options])
    end

    def get_health(options = {})
      request('getHealth', [options])
    end

    def get_highest_snapshot_slot(options = {})
      request('getHighestSnapshotSlot', [options])
    end

    def get_identity(options = {})
      request('getIdentity', [options])
    end

    def get_inflation_governor(options = {})
      request('getInflationGovernor', [options])
    end

    def get_inflation_rate(options = {})
      request('getInflationRate', [options])
    end

    def get_inflation_reward(addresses, options = {})
      request('getInflationReward', [addresses, options])
    end

    def get_largest_accounts(options = {})
      request('getLargestAccounts', [options])
    end

    def get_latest_blockhash(options = {})
      request('getLatestBlockhash', [options])
    end

    def get_leader_schedule(options = {})
      request('getLeaderSchedule', [options])
    end

    def get_max_retransmit_slot(options = {})
      request('getMaxRetransmitSlot', [options])
    end

    def get_max_shred_insert_slot(options = {})
      request('getMaxShredInsertSlot', [options])
    end

    def get_minimum_balance_for_rent_exemption(data_length, options = {})
      request('getMinimumBalanceForRentExemption', [data_length, options])
    end

    def get_multiple_accounts(pubkeys, options = {})
      request('getMultipleAccounts', [pubkeys, options])
    end

    def get_program_accounts(pubkey, options = {})
      request('getProgramAccounts', [pubkey, options])
    end

    def get_recent_performance_samples(options = {})
      request('getRecentPerformanceSamples', [options])
    end

    def get_recent_prioritization_fees(options = {})
      request('getRecentPrioritizationFees', [options])
    end

    def get_signature_statuses(signatures, options = {})
      request('getSignatureStatuses', [signatures, options])
    end

    def get_signatures_for_address(address, options = {})
      request('getSignaturesForAddress', [address, options])
    end

    def get_slot(options = {})
      request('getSlot', [options])
    end

    def get_slot_leader(options = {})
      request('getSlotLeader', [options])
    end

    def get_slot_leaders(start_slot, limit, options = {})
      request('getSlotLeaders', [start_slot, limit, options])
    end

    def get_stake_activation(pubkey, options = {})
      request('getStakeActivation', [pubkey, options])
    end

    def get_stake_minimum_delegation(options = {})
      request('getStakeMinimumDelegation', [options])
    end

    def get_supply(options = {})
      request('getSupply', [options])
    end

    def get_token_account_balance(pubkey, options = {})
      request('getTokenAccountBalance', [pubkey, options])
    end

    def get_token_accounts_by_delegate(delegate, opts = {}, options = {})
      request('getTokenAccountsByDelegate', [delegate, opts, options])
    end

    def get_token_accounts_by_owner(owner, opts = {}, options = {})
      request('getTokenAccountsByOwner', [owner, opts, options])
    end

    def get_token_largest_accounts(pubkey, options = {})
      request('getTokenLargestAccounts', [pubkey, options])
    end

    def get_token_supply(pubkey, options = {})
      request('getTokenSupply', [pubkey, options])
    end

    def get_transaction(signature, options = {})
      request('getTransaction', [signature, options])
    end

    def get_transaction_count(options = {})
      request('getTransactionCount', [options])
    end

    def get_version(options = {})
      request('getVersion', [options])
    end

    def get_vote_accounts(options = {})
      request('getVoteAccounts', [options])
    end

    def is_blockhash_valid(blockhash, options = {})
      request('isBlockhashValid', [blockhash, options])
    end

    def minimum_ledger_slot(options = {})
      request('minimumLedgerSlot', [options])
    end

    def request_airdrop(pubkey, lamports, options = {})
      request('requestAirdrop', [pubkey, lamports, options])
    end

    def send_transaction(transaction, options = {})
      request('sendTransaction', [transaction, options])
    end

    def simulate_transaction(transaction, options = {})
      request('simulateTransaction', [transaction, options])
    end

    private

    def request(method, params = [])
      options = {
        headers: { 'Content-Type' => 'application/json' },
        body: {
          jsonrpc: '2.0',
          method: method,
          params: params,
          id: 1
        }.to_json
      }
      response = self.class.post('/', options)
      handle_response(response)
    end

    def handle_response(response)
      if response.success?
        response.parsed_response['result']
      else
        raise "Request failed: #{response.code} #{response.message}"
      end
    end
  end
end
