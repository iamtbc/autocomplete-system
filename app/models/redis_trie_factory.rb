class RedisTrieFactory
  def initialize(redis_gateway:)
    @redis_gateway = redis_gateway
  end

  def create
    RedisTrie.new(redis_gateway: @redis_gateway)
  end
end
