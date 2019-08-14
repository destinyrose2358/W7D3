class MaxIntSet
  attr_accessor :store

  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    store[num] = true
  end

  def remove(num)
    store[num] = false
  end

  def include?(num)
    store[num]
  end

  private
  attr_reader :max
  

  def is_valid?(num)
    num.between?(0,max)
  end

  def validate!(num)

  end
end


class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    store.length
  end
end

require "byebug"

class ResizingIntSet
  attr_reader :count
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    #debugger
    unless include?(num)
      
      if count + 1 > num_buckets
        resize!
      end
      self[num] << num
      self.count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num) 
      self.count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  attr_writer :count

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
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
