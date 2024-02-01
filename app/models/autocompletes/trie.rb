module Autocompletes
  class Trie
    class Node
      attr_accessor :str, :count, :children, :autocompletes

      AUTOCOMPLETE_SIZE = 5

      def initialize(str)
        @str= str
        @count = 0
        @children = {}
        @autocompletes = []
      end

      def append(index:, word:, count:)
        # create node if it doesn't exist
        char = word[index]
        @children[char] ||= Node.new(word[0..index])
        node = @children[char]

        # update autocomplete list
        node.autocompletes << [ word, count ]
        node.autocompletes = node.autocompletes.sort_by { -_2 }[0..AUTOCOMPLETE_SIZE]

        # update count if this is the last character
        node.count = count if index == word.length - 1

        node
      end
    end

    def initialize
      @root = Node.new("")
    end

    def insert(word, count)
      node = @root
      word.each_char.with_index do |char, index|
        node = node.append(index:, word:, count:)
      end

      node
    end

    def search(word)
      node = @root
      word.each_char do |char|
        return nil unless node.children[char]
        node = node.children[char]
      end
      node
    end

    def to_hash_table
      hash_table = {}
      queue = @root.children.values

      until queue.empty?
        node = queue.shift
        hash_table[node.str] = node.autocompletes.to_h
        queue += node.children.values
      end

      hash_table
    end
  end
end
