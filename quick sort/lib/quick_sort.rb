class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.empty?
    left = []
    right = []
    pivot = array.first

    array.each do |el|
      if pivot > el
        left << el
      elsif pivot < el
        right << el
      end
    end
    result = left + pivot + right
    sort1(result)
  end


# In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new {|a, b| a <=> b}

    return array if length < 2

    pivot = partition(array, start, length, &prc)

    left = pivot - start
    sort2!(array, start, left, &prc)

    right = length - (left + 1)
    sort2!(array, pivot + 1, right, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|a, b| a <=> b}

    pivot_idx = start
    pivot = array[start]

    (start + 1).upto(start + length - 1) do |i|
      if prc.call(pivot, array[i]) > 0
        pivot_idx += 1
        array[i], array[pivot_idx] = array[pivot_idx], array[i]
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end
end
