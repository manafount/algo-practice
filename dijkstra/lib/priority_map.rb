require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    @map = {}
    @queue = BinaryMinHeap.new do |el1, el2|
      prc.call(@map[el1], @map[el2])
    end
  end

  def [](key)
    return nil unless @map.has_key?(key)
    @map[key]
  end

  def []=(key, value)
    if @map.has_key?(key)
      update(key, value)
    else
      insert(key, value)
    end
  end

  def count
    @map.count
  end

  def empty?
    count == 0
  end

  def extract
    key = @queue.extract
    value = @map.delete(key)

    [key, value]
  end

  def has_key?(key)
    @map.has_key?(key)
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    @map[key] = value
    @queue.push(key)

    nil
  end

  def update(key, value)
    @map[key] = value
    @queue.reduce!(key)

    nil
  end
end
