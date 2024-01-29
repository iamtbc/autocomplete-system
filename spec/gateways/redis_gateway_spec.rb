require "rails_helper"

RSpec.describe RedisGateway do
  let(:host) { "localhost" }
  let(:port) { 6379 }
  let(:db) { 9 }
  let(:gateway) { RedisGateway.new(host: host, port: port, db: db) }

  let(:redis) { instance_spy(Redis) }
  before do
    allow(Redis).to receive(:new).and_return(redis)
  end

  describe "#get" do
    it "calls Redis#get" do
      gateway.get('test_key')
      expect(redis).to have_received(:get).with('test_key')
    end
  end

  describe "#set" do
    it "calls Redis#set" do
      gateway.set('test_key', 'test_value')
      expect(redis).to have_received(:set).with('test_key', 'test_value')
    end
  end

  describe '#flushdb' do
    it 'calls Redis#flushdb' do
      gateway.flushdb
      expect(redis).to have_received(:flushdb)
    end
  end
end
