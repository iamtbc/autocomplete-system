namespace :autocompletes do
  desc "集計データからトライデータ構造を構築し、トライデータベースに保存します。"
  task import: :environment do
    redis_gateway = RedisGateway.new(
      host: ENV['AUTOCOMPLETE_SYSTEM_CACHE_HOST'],
      port: ENV['AUTOCOMPLETE_SYSTEM_CACHE_PORT'],
      db: ENV['AUTOCOMPLETE_SYSTEM_CACHE_DB']
    )

    importer = Autocompletes::Importer.new(
      trie_initializer: RedisTrieFactory.new(redis_gateway:),
      trie_builder: Frequency
    )

    version = Frequency.maximum(:version)
    importer.import(version:)
  end
end
