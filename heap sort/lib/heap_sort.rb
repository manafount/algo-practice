require_relative 'heap'

class Array
  def heap_sort!
    2.upto(self.count).each do |len|
      BinaryMinHeap.heapify_up(self, len - 1, len)
    end

    self.count.downto(2).each do |len|
      self[len - 1], self[0] = self[0], self[len - 1]
      BinaryMinHeap.heapify_down(self, 0, len - 1)
    end
    
    self.reverse!
  end
end
