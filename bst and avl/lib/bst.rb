class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
    else
      BinarySearchTree.insert!(@root, value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) if node.nil?
    if value <= node.value
      node.left = BinarySearchTree.insert!(node.left, value)
    else
      node.right = BinarySearchTree.insert!(node.right, value)
    end
    node
  end

  def self.find!(node, value)
    return nil if node.nil?
    if value == node.value
      return node
    elsif value <= node.value
      BinarySearchTree.find!(node.left, value)
    else
      BinarySearchTree.find!(node.right, value)
    end
  end

  def self.preorder!(node)
    return [] if node.nil?
    result = []
    result += [node.value]
    result += BinarySearchTree.preorder!(node.left) if node.left
    result += BinarySearchTree.preorder!(node.right) if node.right
    result
  end

  def self.inorder!(node)
    return [] if node.nil?
    result = []
    result += BinarySearchTree.inorder!(node.left) if node.left
    result += [node.value]
    result += BinarySearchTree.inorder!(node.right) if node.right
    result
  end

  def self.postorder!(node)
    return [] if node.nil?
    result = []
    result += BinarySearchTree.postorder!(node.left) if node.left
    result += BinarySearchTree.postorder!(node.right) if node.right
    result += [node.value]
    result
  end

  def self.height!(node)
    return -1 if node.nil?

    left_height = BinarySearchTree.height!(node.left) + 1
    right_height = BinarySearchTree.height!(node.right) + 1

    return [left_height, right_height].max
  end

  def self.max(node)
    return nil if node.nil?
    return node if node.right.nil?
    BinarySearchTree.max(node.right)
  end

  def self.min(node)
    return nil if node.nil?
    return node if node.left.nil?
    BinarySearchTree.min(node.left)
  end

  def self.delete_min!(node)
    return nil if node.nil?
    return node.right if node.left.nil?

    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil if node.nil?

    if value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif value > node.value
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      if node.right.nil?
        return node.left
      elsif node.left.nil?
        return node.right
      end
      t = node
      node = t.right.min
      node.right = BinarySearchTree.delete_min!(t.right)
      node.left = t.left
    end
    node
  end
end
