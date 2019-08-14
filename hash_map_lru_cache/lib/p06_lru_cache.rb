require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require "byebug"

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    map.count
  end

  def get(key)
    debugger
    unless map[key]
      calc!(key)
    end
    map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private
  attr_accessor :store, :map
  attr_reader :max, :prc

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    node = Node.new(key, prc.call(key))
    update_node!(node)
    map.set(key, node)
    eject! if count > max
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.prev.next = node.next if node.prev
    node.next.prev = node.prev if node.next
    store.tail.prev.next = node
    node.prev = store.tail.prev
    store.tail.prev = node
    node.next = store.tail
  end

  def eject!
    node = store.first
    map.delete(node.key)
    node.prev.next = node.next
    node.next.prev = node.prev
  end
end
