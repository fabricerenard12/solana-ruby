require 'faye/websocket'
require 'httpx'
require 'json'
require 'thread'

require_relative 'utils'

module Solana
  ##
  # Client class for interacting with the Solana JSON RPC API over HTTP and WS.
  class Client
    ##
    # Initializes a new Client.
    #
    # @param [String, nil] api_key Optional API key for authentication.
    def initialize(api_endpoint = Solana::Utils::MAINNET, api_key = nil)
      @api_key = api_key
      @api_endpoint = api_endpoint
    end

    ##
    # Retrieves account information for a given public key.
    #
    # @param [String] pubkey The public key of the account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The account information.
    def get_account_info(pubkey, options = {}, &block)
      request_http('getAccountInfo', [pubkey, options], &block)
    end

    ##
    # Retrieves the balance for a given public key.
    #
    # @param [String] pubkey The public key of the account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The balance in lamports.
    def get_balance(pubkey, options = {}, &block)
      request_http('getBalance', [pubkey, options], &block)
    end

    ##
    # Retrieves information about a specific block.
    #
    # @param [Integer] slot_number The slot number of the block.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The block information.
    def get_block(slot_number, options = {}, &block)
      request_http('getBlock', [slot_number, options], &block)
    end

    ##
    # Retrieves block commitment information for a specific block.
    #
    # @param [Integer] slot_number The slot number of the block.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The block commitment information.
    def get_block_commitment(slot_number, options = {}, &block)
      request_http('getBlockCommitment', [slot_number, options], &block)
    end

    ##
    # Retrieves the current block height.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The current block height.
    def get_block_height(options = {}, &block)
      request_http('getBlockHeight', [options], &block)
    end

    ##
    # Retrieves block production information.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The block production information.
    def get_block_production(options = {}, &block)
      request_http('getBlockProduction', [options], &block)
    end

    ##
    # Retrieves the estimated production time of a specific block.
    #
    # @param [Integer] slot_number The slot number of the block.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The estimated production time in seconds.
    def get_block_time(slot_number, options = {}, &block)
      request_http('getBlockTime', [slot_number, options], &block)
    end

    ##
    # Retrieves a list of confirmed blocks between two slot numbers.
    #
    # @param [Integer] start_slot The start slot number.
    # @param [Integer] end_slot The end slot number.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Integer>] The list of confirmed blocks.
    def get_blocks(start_slot, end_slot, options = {}, &block)
      request_http('getBlocks', [start_slot, end_slot, options], &block)
    end

    ##
    # Retrieves a list of confirmed blocks starting from a given slot number with a limit on the number of blocks.
    #
    # @param [Integer] start_slot The start slot number.
    # @param [Integer] limit The maximum number of blocks to return.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Integer>] The list of confirmed blocks.
    def get_blocks_with_limit(start_slot, limit, options = {}, &block)
      request_http('getBlocksWithLimit', [start_slot, limit, options], &block)
    end

    ##
    # Retrieves the list of cluster nodes.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The list of cluster nodes.
    def get_cluster_nodes(options = {}, &block)
      request_http('getClusterNodes', [options], &block)
    end

    ##
    # Retrieves epoch information.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The epoch information.
    def get_epoch_info(options = {}, &block)
      request_http('getEpochInfo', [options], &block)
    end

    ##
    # Retrieves the epoch schedule.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The epoch schedule.
    def get_epoch_schedule(options = {}, &block)
      request_http('getEpochSchedule', [options], &block)
    end

    ##
    # Retrieves the fee for a given message.
    #
    # @param [String] message The message for which the fee is to be calculated.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The fee for the message.
    def get_fee_for_message(message, options = {}, &block)
      request_http('getFeeForMessage', [message, options], &block)
    end

    ##
    # Retrieves the slot of the first available block.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The slot of the first available block.
    def get_first_available_block(options = {}, &block)
      request_http('getFirstAvailableBlock', [options], &block)
    end

    ##
    # Retrieves the genesis hash.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [String] The genesis hash.
    def get_genesis_hash(options = {}, &block)
      request_http('getGenesisHash', [options], &block)
    end

    ##
    # Checks the health of the node.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [String] The health status of the node.
    def get_health(options = {}, &block)
      request_http('getHealth', [options], &block)
    end

    ##
    # Retrieves the highest snapshot slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The highest snapshot slot.
    def get_highest_snapshot_slot(options = {}, &block)
      request_http('getHighestSnapshotSlot', [options], &block)
    end

    ##
    # Retrieves the identity of the node.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The identity information of the node.
    def get_identity(options = {}, &block)
      request_http('getIdentity', [options], &block)
    end

    ##
    # Retrieves the current inflation governor settings.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The inflation governor settings.
    def get_inflation_governor(options = {}, &block)
      request_http('getInflationGovernor', [options], &block)
    end

    ##
    # Retrieves the current inflation rate.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The inflation rate.
    def get_inflation_rate(options = {}, &block)
      request_http('getInflationRate', [options], &block)
    end

    ##
    # Retrieves the inflation reward for a given list of addresses.
    #
    # @param [Array<String>] addresses The list of addresses.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The inflation rewards for the addresses.
    def get_inflation_reward(addresses, options = {}, &block)
      request_http('getInflationReward', [addresses, options], &block)
    end

    ##
    # Retrieves the largest accounts.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The largest accounts.
    def get_largest_accounts(options = {}, &block)
      request_http('getLargestAccounts', [options], &block)
    end

    ##
    # Retrieves the latest blockhash.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The latest blockhash.
    def get_latest_blockhash(options = {}, &block)
      request_http('getLatestBlockhash', [options], &block)
    end

    ##
    # Retrieves the leader schedule.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The leader schedule.
    def get_leader_schedule(options = {}, &block)
      request_http('getLeaderSchedule', [options], &block)
    end

    ##
    # Retrieves the maximum retransmit slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The maximum retransmit slot.
    def get_max_retransmit_slot(options = {}, &block)
      request_http('getMaxRetransmitSlot', [options], &block)
    end

    ##
    # Retrieves the maximum shred insert slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The maximum shred insert slot.
    def get_max_shred_insert_slot(options = {}, &block)
      request_http('getMaxShredInsertSlot', [options], &block)
    end

    ##
    # Retrieves the minimum balance required for rent exemption for a given data length.
    #
    # @param [Integer] data_length The length of the data in bytes.
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The minimum balance for rent exemption.
    def get_minimum_balance_for_rent_exemption(data_length, options = {}, &block)
      request_http('getMinimumBalanceForRentExemption', [data_length, options], &block)
    end

    ##
    # Retrieves information for multiple accounts.
    #
    # @param [Array<String>] pubkeys The list of public keys.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The information for the accounts.
    def get_multiple_accounts(pubkeys, options = {}, &block)
      request_http('getMultipleAccounts', [pubkeys, options], &block)
    end

    ##
    # Retrieves information for accounts owned by a specific program.
    #
    # @param [String] pubkey The public key of the program.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The information for the program accounts.
    def get_program_accounts(pubkey, options = {}, &block)
      request_http('getProgramAccounts', [pubkey, options], &block)
    end

    ##
    # Retrieves recent performance samples.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The recent performance samples.
    def get_recent_performance_samples(options = {}, &block)
      request_http('getRecentPerformanceSamples', [options], &block)
    end

    ##
    # Retrieves recent prioritization fees.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The recent prioritization fees.
    def get_recent_prioritization_fees(options = {}, &block)
      request_http('getRecentPrioritizationFees', [options], &block)
    end

    ##
    # Retrieves the status of given transaction signatures.
    #
    # @param [Array<String>] signatures The list of transaction signatures.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The status of the transaction signatures.
    def get_signature_statuses(signatures, options = {}, &block)
      request_http('getSignatureStatuses', [signatures, options], &block)
    end

    ##
    # Retrieves the signatures for a given address.
    #
    # @param [String] address The address for which to retrieve signatures.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The signatures for the address.
    def get_signatures_for_address(address, options = {}, &block)
      request_http('getSignaturesForAddress', [address, options], &block)
    end

    ##
    # Retrieves the current slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The current slot.
    def get_slot(options = {}, &block)
      request_http('getSlot', [options], &block)
    end

    ##
    # Retrieves the current slot leader.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [String] The current slot leader.
    def get_slot_leader(options = {}, &block)
      request_http('getSlotLeader', [options], &block)
    end

    ##
    # Retrieves the slot leaders starting from a given slot with a limit on the number of leaders.
    #
    # @param [Integer] start_slot The start slot number.
    # @param [Integer] limit The maximum number of leaders to return.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<String>] The slot leaders.
    def get_slot_leaders(start_slot, limit, options = {}, &block)
      request_http('getSlotLeaders', [start_slot, limit, options], &block)
    end

    ##
    # Retrieves the stake activation information for a given public key.
    #
    # @param [String] pubkey The public key of the stake account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The stake activation information.
    def get_stake_activation(pubkey, options = {}, &block)
      request_http('getStakeActivation', [pubkey, options], &block)
    end

    ##
    # Retrieves the minimum delegation for a stake account.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The minimum delegation.
    def get_stake_minimum_delegation(options = {}, &block)
      request_http('getStakeMinimumDelegation', [options], &block)
    end

    ##
    # Retrieves the supply information.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The supply information.
    def get_supply(options = {}, &block)
      request_http('getSupply', [options], &block)
    end

    ##
    # Retrieves the token balance for a given token account.
    #
    # @param [String] pubkey The public key of the token account.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The token balance.
    def get_token_account_balance(pubkey, options = {}, &block)
      request_http('getTokenAccountBalance', [pubkey, options], &block)
    end

    ##
    # Retrieves token accounts by delegate.
    #
    # @param [String] delegate The delegate address.
    # @param [Hash] opts Additional options for the request.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The token accounts by delegate.
    def get_token_accounts_by_delegate(delegate, opts = {}, options = {}, &block)
      request_http('getTokenAccountsByDelegate', [delegate, opts, options], &block)
    end

    ##
    # Retrieves token accounts by owner.
    #
    # @param [String] owner The owner address.
    # @param [Hash] opts Additional options for the request.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The token accounts by owner.
    def get_token_accounts_by_owner(owner, opts = {}, options = {}, &block)
      request_http('getTokenAccountsByOwner', [owner, opts, options], &block)
    end

    ##
    # Retrieves the largest accounts for a given token.
    #
    # @param [String] pubkey The public key of the token.
    # @param [Hash] options Optional parameters for the request.
    # @return [Array<Hash>] The largest accounts for the token.
    def get_token_largest_accounts(pubkey, options = {}, &block)
      request_http('getTokenLargestAccounts', [pubkey, options], &block)
    end

    ##
    # Retrieves the supply of a given token.
    #
    # @param [String] pubkey The public key of the token.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The token supply.
    def get_token_supply(pubkey, options = {}, &block)
      request_http('getTokenSupply', [pubkey, options], &block)
    end

    ##
    # Retrieves transaction details for a given signature.
    #
    # @param [String] signature The transaction signature.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The transaction details.
    def get_transaction(signature, options = {}, &block)
      request_http('getTransaction', [signature, options], &block)
    end

    ##
    # Retrieves the total number of transactions processed by the network.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The total number of transactions.
    def get_transaction_count(options = {}, &block)
      request_http('getTransactionCount', [options], &block)
    end

    ##
    # Retrieves the current version of the Solana software.
    #
    # @return [Hash] The current version information.
    def get_version(&block)
      request_http('getVersion', &block)
    end

    ##
    # Retrieves the list of vote accounts.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The list of vote accounts.
    def get_vote_accounts(options = {}, &block)
      request_http('getVoteAccounts', [options], &block)
    end

    ##
    # Checks if a given blockhash is valid.
    #
    # @param [String] blockhash The blockhash to check.
    # @param [Hash] options Optional parameters for the request.
    # @return [Boolean] Whether the blockhash is valid.
    def is_blockhash_valid(blockhash, options = {}, &block)
      request_http('isBlockhashValid', [blockhash, options], &block)
    end

    ##
    # Retrieves the minimum ledger slot.
    #
    # @param [Hash] options Optional parameters for the request.
    # @return [Integer] The minimum ledger slot.
    def minimum_ledger_slot(options = {}, &block)
      request_http('minimumLedgerSlot', [options], &block)
    end

    ##
    # Requests an airdrop to a given public key.
    #
    # @param [String] pubkey The public key to receive the airdrop.
    # @param [Integer] lamports The amount of lamports to airdrop.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The airdrop request response.
    def request_airdrop(pubkey, lamports, options = {}, &block)
      request_http('requestAirdrop', [pubkey, lamports, options], &block)
    end

    ##
    # Sends a transaction.
    #
    # @param [Hash] transaction The transaction to send.
    # @return [Hash] The response from the send transaction request.
    def send_transaction(transaction, &block)
      request_http('sendTransaction', [transaction.to_json], &block)
    end

    ##
    # Simulates a transaction.
    #
    # @param [Hash] transaction The transaction to simulate.
    # @param [Hash] options Optional parameters for the request.
    # @return [Hash] The simulation response.
    def simulate_transaction(transaction, options = {}, &block)
      request_http('simulateTransaction', [transaction.to_json, options], &block)
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

    private
    ##
    # Sends a JSON-RPC request to the Solana API over HTTP.
    #
    # This method constructs a JSON-RPC request and sends it to the Solana API endpoint using HTTP.
    # It then handles the response asynchronously.
    #
    # @param [String] method The RPC method to call.
    # @param [Array] params The parameters for the RPC method.
    # @yield [Object] The parsed response from the API.
    # @return [Object, nil] The parsed response from the API if no block is given, otherwise nil.
    # @raise [RuntimeError] If the request fails (non-success response).
    def request_http(method, params = nil, &block)
      body = {
        jsonrpc: '2.0',
        method: method,
        id: 1
      }
      body[:params] = params if params

      HTTPX.post(@api_endpoint::HTTP, json: body).then do |response|
        handle_response_http(response, &block)
      rescue => e
        puts "HTTP request failed: #{e}"
      end
    end

    ##
    # Handles the API response, checking for success and parsing the result.
    #
    # This method processes the HTTP response from the Solana API, checking if the request was successful.
    # If successful, it parses the JSON response and yields the result to the provided block.
    #
    # @param [HTTPX::Response] response The HTTP response object.
    # @yield [Object] The parsed result from the API response.
    # @return [Object] The parsed result from the API response.
    # @raise [RuntimeError] If the request fails (non-success response).
    def handle_response_http(response, &block)
      if response.status == 200
        result = JSON.parse(response.body)
        if block_given?
          yield result
        else
          result
        end
      else
        raise "Request failed"
      end
    end

    ##
    # Sends a JSON-RPC request to the Solana API over WebSocket.
    #
    # This method constructs a JSON-RPC request and sends it to the Solana API endpoint using WebSocket.
    # It then handles the response asynchronously, providing the result to the provided block or returning it via a queue.
    #
    # @param [String] method The RPC method to call.
    # @param [Array] params The parameters for the RPC method.
    # @yield [Object] The parsed response from the API.
    # @return [Object, nil] The parsed response from the API if no block is given, otherwise nil.
    # @raise [RuntimeError] If the WebSocket connection fails or an error occurs during communication.
    def request_ws(method, params = nil, &block)
      result_queue = Queue.new
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
          if block_given?
            yield response['result']
          else
            result_queue.push(response['result'])
          end
          ws.close
        end

        ws.on :close do |event|
          ws = nil
          EM.stop
        end

        ws.on :error do |event|
          puts "WebSocket error: #{event.message}"
          result_queue.push(nil)
          ws = nil
          EM.stop
        end
      end
      result_queue.pop unless block_given?
    end
  end
end
