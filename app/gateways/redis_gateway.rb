class RedisGateway
  def initialize(host:, port:, db:)
    @host = host
    @port = port
    @db = db
  end

  delegate :scan, :get, :set, :flushdb, :zadd, :zscan, :zremrangebyrank, to: :client

  private

  def client
    @client ||= Redis.new(host: @host, port: @port, db: @db)
  end
end
