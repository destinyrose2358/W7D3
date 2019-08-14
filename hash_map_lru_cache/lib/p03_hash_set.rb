class HashSet
  attr_reader :count
  

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      resize! if count + 1 > num_buckets
      self[key] << key 
      self.count += 1
    end

  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      self.count -= 1
    end
  end

  private
  attr_writer :count
  attr_accessor :store
  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    contents = store.flatten
    self.store = Array.new(num_buckets * 2) { Array.new }
    self.count = 0
    contents.each do |ele|
      insert(ele)
    end
  end
end
