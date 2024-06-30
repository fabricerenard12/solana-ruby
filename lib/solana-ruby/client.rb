require 'faraday'
require 'faye/websocket'
require 'json'
require 'thread'

require_relative 'utils'

module SolanaRB
  ##
  # Client class for interacting with the Solana JSON RPC API over HTTP and WS.
  class Client
    ##
    # Initializes a new Client.
    #
    # @param [String, nil] api_key Optional API key for authentication.
    def initialize(api_endpoint = SolanaRB::Utils::MAINNET, api_key = nil)
      @api_key = api_key
      @api_endpoint = api_endpoint
      # @api_ws = WebSocket::Handshake::Client.new(url: @api_endpoint::WS)
      @api_http = Faraday.new(url: @api_endpoint::HTTP) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: 'application/json'
        faraday.adapter Faraday.default_adapter
      end
    end

    ##
    # Retrieves account information for a given public key.
    #
    # @param [String] pubkey The public key of the account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The account information.
    def get_account_info(pubkey, options = {})
      request_http('getAccountInfo', [pubkey, options])
    end

    ##
    # Retrieves the balance for a given public key.
    #
    # @param [String] pubkey The public key of the account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The balance in lamports.
    def get_balance(pubkey, options = {})
      request_http('getBalance', [pubkey, options])
    end

    ##
    # Retrieves information about a specific block.
    #
    # @param [Integer] slot_number The slot number of the block.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The block information.
    def get_block(slot_number, options = {})
      request_http('getBlock', [slot_number, options])
    end

    ##
    # Retrieves block commitment information for a specific block.
    #
    # @param [Integer] slot_number The slot number of the block.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The block commitment information.
    def get_block_commitment(slot_number, options = {})
      request_http('getBlockCommitment', [slot_number, options])
    end

    ##
    # Retrieves the current block height.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The current block height.
    def get_block_height(options = {})
      request_http('getBlockHeight', [options])
    end

    ##
    # Retrieves block production information.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The block production information.
    def get_block_production(options = {})
      request_http('getBlockProduction', [options])
    end

    ##
    # Retrieves the estimated production time of a specific block.
    #
    # @param [Integer] slot_number The slot number of the block.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The estimated production time in seconds.
    def get_block_time(slot_number, options = {})
      request_http('getBlockTime', [slot_number, options])
    end

    ##
    # Retrieves a list of confirmed blocks between two slot numbers.
    #
    # @param [Integer] start_slot The start slot number.
    # @param [Integer] end_slot The end slot number.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Integer>] The list of confirmed blocks.
    def get_blocks(start_slot, end_slot, options = {})
      request_http('getBlocks', [start_slot, end_slot, options])
    end

    ##
    # Retrieves a list of confirmed blocks starting from a given slot number with a limit on the number of blocks.
    #
    # @param [Integer] start_slot The start slot number.
    # @param [Integer] limit The maximum number of blocks to return.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Integer>] The list of confirmed blocks.
    def get_blocks_with_limit(start_slot, limit, options = {})
      request_http('getBlocksWithLimit', [start_slot, limit, options])
    end

    ##
    # Retrieves the list of cluster nodes.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The list of cluster nodes.
    def get_cluster_nodes(options = {})
      request_http('getClusterNodes', [options])
    end

    ##
    # Retrieves epoch information.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The epoch information.
    def get_epoch_info(options = {})
      request_http('getEpochInfo', [options])
    end

    ##
    # Retrieves the epoch schedule.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The epoch schedule.
    def get_epoch_schedule(options = {})
      request_http('getEpochSchedule', [options])
    end

    ##
    # Retrieves the fee for a given message.
    #
    # @param [String] message The message for which the fee is to be calculated.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The fee for the message.
    def get_fee_for_message(message, options = {})
      request_http('getFeeForMessage', [message, options])
    end

    ##
    # Retrieves the slot of the first available block.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The slot of the first available block.
    def get_first_available_block(options = {})
      request_http('getFirstAvailableBlock', [options])
    end

    ##
    # Retrieves the genesis hash.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [String] The genesis hash.
    def get_genesis_hash(options = {})
      request_http('getGenesisHash', [options])
    end

    ##
    # Checks the health of the node.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [String] The health status of the node.
    def get_health(options = {})
      request_http('getHealth', [options])
    end

    ##
    # Retrieves the highest snapshot slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The highest snapshot slot.
    def get_highest_snapshot_slot(options = {})
      request_http('getHighestSnapshotSlot', [options])
    end

    ##
    # Retrieves the identity of the node.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The identity information of the node.
    def get_identity(options = {})
      request_http('getIdentity', [options])
    end

    ##
    # Retrieves the current inflation governor settings.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The inflation governor settings.
    def get_inflation_governor(options = {})
      request_http('getInflationGovernor', [options])
    end

    ##
    # Retrieves the current inflation rate.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The inflation rate.
    def get_inflation_rate(options = {})
      request_http('getInflationRate', [options])
    end

    ##
    # Retrieves the inflation reward for a given list of addresses.
    #
    # @param [Array<String>] addresses The list of addresses.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The inflation rewards for the addresses.
    def get_inflation_reward(addresses, options = {})
      request_http('getInflationReward', [addresses, options])
    end

    ##
    # Retrieves the largest accounts.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The largest accounts.
    def get_largest_accounts(options = {})
      request_http('getLargestAccounts', [options])
    end

    ##
    # Retrieves the latest blockhash.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The latest blockhash.
    def get_latest_blockhash(options = {})
      request_http('getLatestBlockhash', [options])
    end

    ##
    # Retrieves the leader schedule.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The leader schedule.
    def get_leader_schedule(options = {})
      request_http('getLeaderSchedule', [options])
    end

    ##
    # Retrieves the maximum retransmit slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The maximum retransmit slot.
    def get_max_retransmit_slot(options = {})
      request_http('getMaxRetransmitSlot', [options])
    end

    ##
    # Retrieves the maximum shred insert slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The maximum shred insert slot.
    def get_max_shred_insert_slot(options = {})
      request_http('getMaxShredInsertSlot', [options])
    end

    ##
    # Retrieves the minimum balance required for rent exemption for a given data length.
    #
    # @param [Integer] data_length The length of the data in bytes.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The minimum balance for rent exemption.
    def get_minimum_balance_for_rent_exemption(data_length, options = {})
      request_http('getMinimumBalanceForRentExemption', [data_length, options])
    end

    ##
    # Retrieves information for multiple accounts.
    #
    # @param [Array<String>] pubkeys The list of public keys.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The information for the accounts.
    def get_multiple_accounts(pubkeys, options = {})
      request_http('getMultipleAccounts', [pubkeys, options])
    end

    ##
    # Retrieves information for accounts owned by a specific program.
    #
    # @param [String] pubkey The public key of the program.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The information for the program accounts.
    def get_program_accounts(pubkey, options = {})
      request_http('getProgramAccounts', [pubkey, options])
    end

    ##
    # Retrieves recent performance samples.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The recent performance samples.
    def get_recent_performance_samples(options = {})
      request_http('getRecentPerformanceSamples', [options])
    end

    ##
    # Retrieves recent prioritization fees.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The recent prioritization fees.
    def get_recent_prioritization_fees(options = {})
      request_http('getRecentPrioritizationFees', [options])
    end

    ##
    # Retrieves the status of given transaction signatures.
    #
    # @param [Array<String>] signatures The list of transaction signatures.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The status of the transaction signatures.
    def get_signature_statuses(signatures, options = {})
      request_http('getSignatureStatuses', [signatures, options])
    end

    ##
    # Retrieves the signatures for a given address.
    #
    # @param [String] address The address for which to retrieve signatures.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The signatures for the address.
    def get_signatures_for_address(address, options = {})
      request_http('getSignaturesForAddress', [address, options])
    end

    ##
    # Retrieves the current slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The current slot.
    def get_slot(options = {})
      request_http('getSlot', [options])
    end

    ##
    # Retrieves the current slot leader.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [String] The current slot leader.
    def get_slot_leader(options = {})
      request_http('getSlotLeader', [options])
    end

    ##
    # Retrieves the slot leaders starting from a given slot with a limit on the number of leaders.
    #
    # @param [Integer] start_slot The start slot number.
    # @param [Integer] limit The maximum number of leaders to return.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<String>] The slot leaders.
    def get_slot_leaders(start_slot, limit, options = {})
      request_http('getSlotLeaders', [start_slot, limit, options])
    end

    ##
    # Retrieves the stake activation information for a given public key.
    #
    # @param [String] pubkey The public key of the stake account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The stake activation information.
    def get_stake_activation(pubkey, options = {})
      request_http('getStakeActivation', [pubkey, options])
    end

    ##
    # Retrieves the minimum delegation for a stake account.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The minimum delegation.
    def get_stake_minimum_delegation(options = {})
      request_http('getStakeMinimumDelegation', [options])
    end

    ##
    # Retrieves the supply information.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The supply information.
    def get_supply(options = {})
      request_http('getSupply', [options])
    end

    ##
    # Retrieves the token balance for a given token account.
    #
    # @param [String] pubkey The public key of the token account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The token balance.
    def get_token_account_balance(pubkey, options = {})
      request_http('getTokenAccountBalance', [pubkey, options])
    end

    ##
    # Retrieves token accounts by delegate.
    #
    # @param [String] delegate The delegate address.
    # @param [Hash] opts Additional options for the request.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The token accounts by delegate.
    def get_token_accounts_by_delegate(delegate, opts = {}, options = {})
      request_http('getTokenAccountsByDelegate', [delegate, opts, options])
    end

    ##
    # Retrieves token accounts by owner.
    #
    # @param [String] owner The owner address.
    # @param [Hash] opts Additional options for the request.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The token accounts by owner.
    def get_token_accounts_by_owner(owner, opts = {}, options = {})
      request_http('getTokenAccountsByOwner', [owner, opts, options])
    end

    ##
    # Retrieves the largest accounts for a given token.
    #
    # @param [String] pubkey The public key of the token.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The largest accounts for the token.
    def get_token_largest_accounts(pubkey, options = {})
      request_http('getTokenLargestAccounts', [pubkey, options])
    end

    ##
    # Retrieves the supply of a given token.
    #
    # @param [String] pubkey The public key of the token.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The token supply.
    def get_token_supply(pubkey, options = {})
      request_http('getTokenSupply', [pubkey, options])
    end

    ##
    # Retrieves transaction details for a given signature.
    #
    # @param [String] signature The transaction signature.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The transaction details.
    def get_transaction(signature, options = {})
      request_http('getTransaction', [signature, options])
    end

    ##
    # Retrieves the total number of transactions processed by the network.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The total number of transactions.
    def get_transaction_count(options = {})
      request_http('getTransactionCount', [options])
    end

    ##
    # Retrieves the current version of the Solana software.
    #
    # @return [Hash] The current version information.
    def get_version
      request_http('getVersion')
    end

    ##
    # Retrieves the list of vote accounts.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The list of vote accounts.
    def get_vote_accounts(options = {})
      request_http('getVoteAccounts', [options])
    end

    ##
    # Checks if a given blockhash is valid.
    #
    # @param [String] blockhash The blockhash to check.
    # @param [Hash] options Optional parameters for the request.
    # @return [Boolean] Whether the blockhash is valid.
    def is_blockhash_valid(blockhash, options = {})
      request_http('isBlockhashValid', [blockhash, options])
    end

    ##
    # Retrieves the minimum ledger slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The minimum ledger slot.
    def minimum_ledger_slot(options = {})
      request_http('minimumLedgerSlot', [options])
    end

    ##
    # Requests an airdrop to a given public key.
    #
    # @param [String] pubkey The public key to receive the airdrop.
    # @param [Integer] lamports The amount of lamports to airdrop.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The airdrop request response.
    def request_airdrop(pubkey, lamports, options = {})
      request_http('requestAirdrop', [pubkey, lamports, options])
    end

    ##
    # Sends a transaction.
    #
    # @param [Hash] transaction The transaction to send.
    # @return [Hash] The response from the send transaction request.
    def send_transaction(transaction)
      request_http('sendTransaction', [transaction.to_json])
    end

    ##
    # Simulates a transaction.
    #
    # @param [Hash] transaction The transaction to simulate.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The simulation response.
    def simulate_transaction(transaction, options = {})
      request_http('simulateTransaction', [transaction.to_json, options])
    end

    ##
    # Subscribes to account changes.
    #
    # @param [String] pubkey The public key of the account.
    # @param [Hash] options Optional parameters for the subscription.
    # @yield [Object] The response from the subscription.
    def account_subscribe(pubkey, options = {}, &block)
      request_ws('accountSubscribe', [pubkey, options], &block)
    end

    ##
    # Unsubscribes from account changes.
    #
    # @param [Integer] subscription_id The subscription ID.
    # @yield [Object] The response from the unsubscription.
    def account_unsubscribe(subscription_id, &block)
      request_ws('accountUnsubscribe', [subscription_id], &block)
    end

    ##
    # Subscribes to new blocks.
    #
    # @param [Hash] options Optional parameters for the subscription.
    # @yield [Object] The response from the subscription.
    def block_subscribe(options = {}, &block)
      request_ws('blockSubscribe', [options], &block)
    end

    ##
    # Unsubscribes from new blocks.
    #
    # @param [Integer] subscription_id The subscription ID.
    # @yield [Object] The response from the unsubscription.
    def block_unsubscribe(subscription_id, &block)
      request_ws('blockUnsubscribe', [subscription_id], &block)
    end

    ##
    # Subscribes to log messages.
    #
    # @param [String, Hash] filter The filter for log messages (e.g., a public key or a set of options).
    # @param [Hash] options Optional parameters for the subscription.
    # @yield [Object] The response from the subscription.
    def logs_subscribe(filter, options = {}, &block)
      request_ws('logsSubscribe', [filter, options], &block)
    end

    ##
    # Unsubscribes from log messages.
    #
    # @param [Integer] subscription_id The subscription ID.
    # @yield [Object] The response from the unsubscription.
    def logs_unsubscribe(subscription_id, &block)
      request_ws('logsUnsubscribe', [subscription_id], &block)
    end

    ##
    # Subscribes to program changes.
    #
    # @param [String] pubkey The public key of the program.
    # @param [Hash] options Optional parameters for the subscription.
    # @yield [Object] The response from the subscription.
    def program_subscribe(pubkey, options = {}, &block)
      request_ws('programSubscribe', [pubkey, options], &block)
    end

    ##
    # Unsubscribes from program changes.
    #
    # @param [Integer] subscription_id The subscription ID.
    # @yield [Object] The response from the unsubscription.
    def program_unsubscribe(subscription_id, &block)
      request_ws('programUnsubscribe', [subscription_id], &block)
    end

    ##
    # Subscribes to root changes.
    #
    # @yield [Object] The response from the subscription.
    def root_subscribe(&block)
      request_ws('rootSubscribe', &block)
    end

    ##
    # Unsubscribes from root changes.
    #
    # @param [Integer] subscription_id The subscription ID.
    # @yield [Object] The response from the unsubscription.
    def root_unsubscribe(subscription_id, &block)
      request_ws('rootUnsubscribe', [subscription_id], &block)
    end

    ##
    # Subscribes to signature status changes.
    #
    # @param [String] signature The signature to monitor.
    # @param [Hash] options Optional parameters for the subscription.
    # @yield [Object] The response from the subscription.
    def signature_subscribe(signature, options = {}, &block)
      request_ws('signatureSubscribe', [signature, options], &block)
    end

    ##
    # Unsubscribes from signature status changes.
    #
    # @param [Integer] subscription_id The subscription ID.
    # @yield [Object] The response from the unsubscription.
    def signature_unsubscribe(subscription_id, &block)
      request_ws('signatureUnsubscribe', [subscription_id], &block)
    end

    ##
    # Subscribes to slot changes.
    #
    # @yield [Object] The response from the subscription.
    def slot_subscribe(&block)
      request_ws('slotSubscribe', &block)
    end

    ##
    # Unsubscribes from slot changes.
    #
    # @param [Integer] subscription_id The subscription ID.
    # @yield [Object] The response from the unsubscription.
    def slot_unsubscribe(subscription_id, &block)
      request_ws('slotUnsubscribe', [subscription_id], &block)
    end

    ##
    # Subscribes to slot updates.
    #
    # @yield [Object] The response from the subscription.
    def slots_updates_subscribe(&block)
      request_ws('slotsUpdatesSubscribe', &block)
    end

    ##
    # Unsubscribes from slot updates.
    #
    # @param [Integer] subscription_id The subscription ID.
    # @yield [Object] The response from the unsubscription.
    def slots_updates_unsubscribe(subscription_id, &block)
      request_ws('slotsUpdatesUnsubscribe', [subscription_id], &block)
    end

    ##
    # Subscribes to vote updates.
    #
    # @yield [Object] The response from the subscription.
    def vote_subscribe(&block)
      request_ws('voteSubscribe', &block)
    end

    ##
    # Unsubscribes from vote updates.
    #
    # @param [Integer] subscription_id The subscription ID.
    # @yield [Object] The response from the unsubscription.
    def vote_unsubscribe(subscription_id, &block)
      request_ws('voteUnsubscribe', [subscription_id], &block)
    end

    ##
    # Sends a JSON-RPC request to the Solana API.
    #
    # @param [String] method The RPC method to call.
    # @param [Array] params The parameters for the RPC method.
    # @return [Object] The parsed response from the API.
    def request_http(method, params = nil)
      body = {
        jsonrpc: '2.0',
        method: method,
        id: 1
      }
      body[:params] = params if params

      response = @api_http.post do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = body.to_json
      end

      handle_response_http(response)
    end

    ##
    # Handles the API response, checking for success and parsing the result.
    #
    # @param [Faraday::Response] response The HTTP response object.
    # @raise [RuntimeError] If the request fails (non-success response).
    # @return [Object] The parsed result from the API response.
    def handle_response_http(response)
      if response.success?
        response.body['result']
      else
        raise "Request failed: #{response.status} #{response.reason_phrase}"
      end
    end

    ##
    # Sends a JSON-RPC request to the Solana API over WebSocket.
    #
    # @param [String] method The RPC method to call.
    # @param [Array] params The parameters for the RPC method.
    # @yield [Object] The parsed response from the API.

    def request_ws(method, params = nil, &block)
      EM.run do
        ws = Faye::WebSocket::Client.new(@api_endpoint::WS)

        ws.on :open do |event|
          body = {
            jsonrpc: '2.0',
            method: method,
            id: 1
          }
          body[:params] = params if params

          ws.send(body.to_json)
        end

        ws.on :message do |event|
          response = JSON.parse(event.data)
          yield response['result'] if block_given?
          ws.close
        end

        ws.on :close do |event|
          ws = nil
          EM.stop
        end

        ws.on :error do |event|
          puts "WebSocket error: #{event.message}"
          ws = nil
          EM.stop
        end
      end
    end
  end
end
