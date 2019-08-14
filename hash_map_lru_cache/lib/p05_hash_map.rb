require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    unless include?(key)
      resize! if count + 1 > num_buckets
      bucket(key).append(key, val)
      self.count += 1
    else
      bucket(key).update(key, val)
    end
  end

  def get(key)
    bucket = bucket(key)
    bucket.get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      self.count -= 1
    end
  end

  def each
    store.each do |bucket|
      bucket.each do |node|
        key, val = node.key, node.val
        yield(key, val)
      end
    end
  end

  #uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  attr_accessor :store

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    each do |key, val|
      new_store[key.hash % (num_buckets * 2)].append(key, val)
    end
    self.store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    store[key.hash % num_buckets]
  end
end



# Once you're done, you should have a fully functioning
#  hash map that can use numbers, strings, arrays,
#  or hashes as keys. Show off your understanding by asking a TA for a Code Review.

if __FILE__ == $PROGRAM_NAME

  puts " hash with numbers "
  number_hash = HashMap.new()
  number_hash.set(1,2)
  number_hash.set(3,5)
  puts number_hash
end