# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

INITIAL_VERSION = '20240130003709'
initial_data = [
  { query: "ballet", count: 7, version: INITIAL_VERSION },
  { query: "bicycle", count: 6, version: INITIAL_VERSION },
  { query: "book", count: 9, version: INITIAL_VERSION },
  { query: "breeze", count: 7, version: INITIAL_VERSION },
  { query: "butterfly", count: 8, version: INITIAL_VERSION },
  { query: "cactus", count: 12, version: INITIAL_VERSION },
  { query: "camera", count: 9, version: INITIAL_VERSION },
  { query: "candle", count: 7, version: INITIAL_VERSION },
  { query: "carousel", count: 7, version: INITIAL_VERSION },
  { query: "chocolate", count: 7, version: INITIAL_VERSION },
  { query: "cloud", count: 9, version: INITIAL_VERSION },
  { query: "coffee", count: 6, version: INITIAL_VERSION },
  { query: "computer", count: 15, version: INITIAL_VERSION },
  { query: "desert", count: 6, version: INITIAL_VERSION },
  { query: "firefly", count: 10, version: INITIAL_VERSION },
  { query: "fireworks", count: 5, version: INITIAL_VERSION },
  { query: "flower", count: 3, version: INITIAL_VERSION },
  { query: "fog", count: 13, version: INITIAL_VERSION },
  { query: "garden", count: 9, version: INITIAL_VERSION },
  { query: "guitar", count: 12, version: INITIAL_VERSION },
  { query: "ice cream", count: 4, version: INITIAL_VERSION },
  { query: "jazz", count: 11, version: INITIAL_VERSION },
  { query: "keyboard", count: 8, version: INITIAL_VERSION },
  { query: "kite", count: 13, version: INITIAL_VERSION },
  { query: "maple", count: 5, version: INITIAL_VERSION },
  { query: "microphone", count: 7, version: INITIAL_VERSION },
  { query: "moon", count: 8, version: INITIAL_VERSION },
  { query: "mountain", count: 5, version: INITIAL_VERSION },
  { query: "music", count: 10, version: INITIAL_VERSION },
  { query: "oasis", count: 6, version: INITIAL_VERSION },
  { query: "ocean", count: 4, version: INITIAL_VERSION },
  { query: "origami", count: 9, version: INITIAL_VERSION },
  { query: "oxygen", count: 12, version: INITIAL_VERSION },
  { query: "penguin", count: 14, version: INITIAL_VERSION },
  { query: "piano", count: 10, version: INITIAL_VERSION },
  { query: "pineapple", count: 5, version: INITIAL_VERSION },
  { query: "rainbow", count: 11, version: INITIAL_VERSION },
  { query: "robot", count: 15, version: INITIAL_VERSION },
  { query: "sky", count: 7, version: INITIAL_VERSION },
  { query: "skyscraper", count: 11, version: INITIAL_VERSION },
  { query: "snorkel", count: 6, version: INITIAL_VERSION },
  { query: "star", count: 11, version: INITIAL_VERSION },
  { query: "sunflower", count: 4, version: INITIAL_VERSION },
  { query: "sunset", count: 8, version: INITIAL_VERSION },
  { query: "telephone", count: 7, version: INITIAL_VERSION },
  { query: "tornado", count: 11, version: INITIAL_VERSION },
  { query: "umbrella", count: 8, version: INITIAL_VERSION },
  { query: "volcano", count: 14, version: INITIAL_VERSION },
  { query: "whale", count: 10, version: INITIAL_VERSION },
  { query: "whistle", count: 15, version: INITIAL_VERSION }
]

Frequency.upsert_all(initial_data, unique_by: [ :query, :version ])
