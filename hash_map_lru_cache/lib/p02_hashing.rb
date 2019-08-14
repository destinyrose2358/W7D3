class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    count = 0
    self.each_with_index do |ele, idx|
      count += ele.hash * (idx + 1)
    end

    count.hash
  end
end

class String
  def hash
    count = 0 
    self.each_char.with_index do |char, idx|
      count += char.ord * (idx + 1)
    end
    count.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
