require_relative 'graph'

def topological_sort(vertices)
  result = []
  edges = Hash.new(0)
  queue = []

  vertices.each do |vertex|
    edges[vertex] = vertex.in_edges.count
    queue << vertex if vertex.in_edges.empty?
  end
  while queue.count > 0
    current_vertex = queue.shift
    result << current_vertex

    current_vertex.out_edges.each do |edge|
      to_vertex = edge.to_vertex

      edges[to_vertex] -= 1
      queue << to_vertex if edges[to_vertex].zero?
    end
  end
  result
end
