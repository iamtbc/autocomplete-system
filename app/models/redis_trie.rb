class RedisTrie
  TOP_N = 5
  PREFIX = "RedisTrie"

  def initialize(redis_gateway:)
    @redis_gateway = redis_gateway
    @uuid = SecureRandom.uuid
  end

  def insert(word, count)
    for i in 0...word.length
      chars = word[0..i]
      key = key_for(chars)

      @redis_gateway.zadd(key, count, word)
      @redis_gateway.zremrangebyrank(key, 0, -TOP_N - 1)
    end
  end

  def search(query)
    key = key_for(query)
    ret = @redis_gateway.zscan(key, 0)

    ret.last.sort_by { |x| -x[1] }.map { |x| [ x[0], x[1].to_i ] }
  end


  # @param count [Integer] return count keys at most per iteration
  def find_in_batches(count: 1000, &block)
    cursor = "0"
    match = "#{unique_prefix}*"

    loop do
      cursor, keys = @redis_gateway.scan(cursor, match:, count:)

      sets = keys.map do |key|
        _, set = @redis_gateway.zscan(key, 0)

        query = key.sub("#{unique_prefix}", "")
        values = set.sort_by { |x| -x[1] }.map { |x| [ x[0], x[1].to_i ] }
        [ query, values ]
      end

      yield sets if keys.present?

      break if cursor == "0"
    end
  end

  private

  def key_for(word)
    "#{unique_prefix}#{word}"
  end

  def unique_prefix
    "#{PREFIX}:#{@uuid}:"
  end
end
