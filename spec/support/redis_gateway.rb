RSpec.shared_context 'use redis_gateway' do
  let(:host) { ENV["AUTOCOMPLETE_SYSTEM_CACHE_HOST"] }
  let(:port) { ENV["AUTOCOMPLETE_SYSTEM_CACHE_PORT"] }
  let(:db) { 9 }
  let(:redis_gateway) { RedisGateway.new(host: host, port: port, db: db) }

  after do
    redis_gateway.flushdb
  end
end
