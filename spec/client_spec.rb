require 'rspec'
require 'webmock/rspec'
require 'solana-ruby'

RSpec.describe SolanaRB::Client do
  let(:client) { SolanaRB::Client.new }
  let(:base_url) { 'https://api.mainnet-beta.solana.com' }
  let(:headers) { { 'Content-Type' => 'application/json' } }

  before do
    stub_request(:post, base_url).to_return(
      status: 200,
      body: { jsonrpc: '2.0', result: 'test_result', id: 1 }.to_json,
      headers: headers
    )
  end

  describe '#initialize' do
    it 'initializes with an optional API key' do
      client_with_key = SolanaRB::Client.new('api_key')
      expect(client_with_key.instance_variable_get(:@api_key)).to eq('api_key')
    end

    it 'initializes without an API key' do
      expect(client.instance_variable_get(:@api_key)).to be_nil
    end
  end

  describe 'API methods' do
    api_methods = {
      get_account_info: ['pubkey', {}],
      get_balance: ['pubkey', {}],
      get_block: [12345, {}],
      get_block_commitment: [12345, {}],
      get_block_height: [{}],
      get_block_production: [{}],
      get_block_time: [12345, {}],
      get_blocks: [12345, 12346, {}],
      get_blocks_with_limit: [12345, 10, {}],
      get_cluster_nodes: [{}],
      get_epoch_info: [{}],
      get_epoch_schedule: [{}],
      get_fee_for_message: ['message', {}],
      get_first_available_block: [{}],
      get_genesis_hash: [{}],
      get_health: [{}],
      get_highest_snapshot_slot: [{}],
      get_identity: [{}],
      get_inflation_governor: [{}],
      get_inflation_rate: [{}],
      get_inflation_reward: [['address1'], {}],
      get_largest_accounts: [{}],
      get_latest_blockhash: [{}],
      get_leader_schedule: [{}],
      get_max_retransmit_slot: [{}],
      get_max_shred_insert_slot: [{}],
      get_minimum_balance_for_rent_exemption: [1000, {}],
      get_multiple_accounts: [['pubkey1', 'pubkey2'], {}],
      get_program_accounts: ['pubkey', {}],
      get_recent_performance_samples: [{}],
      get_recent_prioritization_fees: [{}],
      get_signature_statuses: [['signature1'], {}],
      get_signatures_for_address: ['address', {}],
      get_slot: [{}],
      get_slot_leader: [{}],
      get_slot_leaders: [12345, 10, {}],
      get_stake_activation: ['pubkey', {}],
      get_stake_minimum_delegation: [{}],
      get_supply: [{}],
      get_token_account_balance: ['pubkey', {}],
      get_token_accounts_by_delegate: ['delegate', {}, {}],
      get_token_accounts_by_owner: ['owner', {}, {}],
      get_token_largest_accounts: ['pubkey', {}],
      get_token_supply: ['pubkey', {}],
      get_transaction: ['signature', {}],
      get_transaction_count: [{}],
      get_version: [{}],
      get_vote_accounts: [{}],
      is_blockhash_valid: ['blockhash', {}],
      minimum_ledger_slot: [{}],
      request_airdrop: ['pubkey', 1000, {}],
      send_transaction: ['transaction', {}],
      simulate_transaction: ['transaction', {}]
    }

    api_methods.each do |method, args|
      it "calls the #{method} API method" do
        camel_case_method = method.to_s.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$2.capitalize}" }
        expect(client).to receive(:request).with(camel_case_method, args)
        client.send(method, *args)
      end
    end
  end

  describe 'private methods' do
    let(:response) { double('response', success?: true, parsed_response: { 'result' => 'test_result' }) }

    it 'sends a request' do
      allow(client.class).to receive(:post).and_return(response)
      result = client.send(:request, 'testMethod', ['param1'])
      expect(result).to eq('test_result')
    end

    it 'handles a successful response' do
      result = client.send(:handle_response, response)
      expect(result).to eq('test_result')
    end

    it 'raises an error for a failed response' do
      failed_response = double('response', success?: false, code: 500, message: 'Internal Server Error')
      expect { client.send(:handle_response, failed_response) }.to raise_error(RuntimeError, 'Request failed: 500 Internal Server Error')
    end
  end
end
