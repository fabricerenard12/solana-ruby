require 'httparty'
require 'json'

module SolanaRB
  class Client
    include HTTParty
    base_uri 'https://api.mainnet-beta.solana.com'

    def initialize(api_key = nil)
      @api_key = api_key
    end

    def get_account_info(pubkey, commitment = nil)
      if commitment
        request('getAccountInfo', [pubkey, { commitment: commitment }])
      else
        request('getAccountInfo', [pubkey])
      end
    end

    def get_balance(pubkey, commitment = nil)
      if commitment
        request('getBalance', [pubkey, { commitment: commitment }])
      else
        request('getBalance', [pubkey])
      end
    end

    def get_block(slot_number)
      request('getBlock', [slot_number])
    end

    def get_block_commitment(slot_number)
      request('getBlockCommitment', [slot_number])
    end

    def get_block_height()
      request('getBlockHeight')
    end

    def get_block_production()
      request('getBlockProduction')
    end

    def get_block_time(slot_number)
      request('getBlockTime', [slot_number])
    end

    private

    def request(method, params)
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
