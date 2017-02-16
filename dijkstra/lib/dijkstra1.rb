require_relative 'graph'

def dijkstra1(src)
  shortest_paths = {}
  possible_paths = { src => { cost: 0, last_edge: nil } }

  until possible_paths.empty?
    vertex = select_possible_path(possible_paths)
    shortest_paths[vertex] = possible_paths[vertex]
    possible_paths.delete(vertex)
    update_possible_paths(vertex, shortest_paths, possible_paths)
  end
  shortest_paths
end

def select_possible_path(possible_paths)
  vertex, data = possible_paths.min_by do |(vertex, data)|
    data[:cost]
  end
  vertex
end

def update_possible_paths(vertex, shortest_paths, possible_paths)
  path_to_vertex_cost = shortest_paths[vertex][:cost]
  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    next if shortest_paths.has_key?(to_vertex)
    extended_path_cost = path_to_vertex_cost + edge.cost
    next if possible_paths.has_key?(to_vertex) && possible_paths[to_vertex][:cost] <= extended_path_cost
    possible_paths[to_vertex] = {
      cost: extended_path_cost,
      last_edge: edge
    }
  end
end
