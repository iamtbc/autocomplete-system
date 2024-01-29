class RedisGateway
  def initialize(host:, port:, db:)
    @host = host
    @port = port
    @db = db
  end

  delegate :get, :set, :flushdb, to: :client

  private

  def client
    @client ||= Redis.new(host: @host, port: @port, db: @db)
  end
end
