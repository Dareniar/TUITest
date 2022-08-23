//
//  Dijkstra.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import Foundation

final class Dijkstra<Element: Equatable> {
  
  private var destinations = [Destination<Element>]()
  private var queue = PriorityQueue<Vertex<Element>>()
  
  init(graph: Graph<Element>, source: Vertex<Element>) {
    graph.vertices.forEach { destinations.append(Destination($0)) }
    
    let sourceDestination = destination(for: source)
    sourceDestination.totalWeight = 0.0
    
    queue.push(source, priority: 0.0)
    
    while !queue.isEmpty {
      if let min = queue.pop() {
        dijkstraStep(for: min)
      }
    }
  }
  
  func distance(to vertex: Vertex<Element>) -> Double {
    destination(for: vertex).totalWeight
  }
  
  func hasPath(to vertex: Vertex<Element>) -> Bool {
    destination(for: vertex).isReachable
  }
  
  func path(to vertex: Vertex<Element>) -> [Vertex<Element>]? {
    guard hasPath(to: vertex) else { return nil }
    
    var results = [vertex]
    var currentDestination = destination(for: vertex)
    
    while let previousVertex = currentDestination.previousVertex {
      results.insert(previousVertex, at: 0)
      currentDestination = destination(for: previousVertex)
    }
    
    return results
  }
  
  private func dijkstraStep(for vertex: Vertex<Element>) {
    vertex.adjacentEdges.forEach { edge in
      let nextDestination = destination(for: edge.destination)
      let currentDestination = destination(for: vertex)
      
      if nextDestination.totalWeight > (currentDestination.totalWeight + edge.weight) {
        nextDestination.totalWeight = currentDestination.totalWeight + edge.weight
        nextDestination.previousVertex = edge.source
        queue.push(nextDestination.vertex, priority: nextDestination.totalWeight)
      }
    }
  }
  
  private func destination(for vertex: Vertex<Element>) -> Destination<Element> {
    destinations.filter { $0.vertex == vertex }.first ?? Destination(vertex)
  }
}
