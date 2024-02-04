require 'rails_helper'

RSpec.describe RedisTrieFactory, type: :model do
  describe "#create" do
    let(:redis_gateway) { double("RedisGateway") }
    let(:factory) { RedisTrieFactory.new(redis_gateway: redis_gateway) }

    it "creates a new RedisTrie instance with the given redis_gateway" do
      expect(RedisTrie).to receive(:new).with(redis_gateway: redis_gateway)

      factory.create
    end
  end
end
