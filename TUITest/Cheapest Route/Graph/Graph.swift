//
//  Graph.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import Foundation

final class Graph<Element: Equatable> {
  private(set) var vertices: [Vertex<Element>] = []
  
  var edges: [Edge<Element>] {
    vertices.reduce([], { $0 + $1.adjacentEdges })
  }
  
  var edgesCount: Int {
    edges.count
  }
  
  var verticesCount: Int {
    vertices.count
  }
  
  func addVertex(_ vertex: Vertex<Element>) {
    vertices.append(vertex)
  }
  
  func vertex(for element: Element) -> Vertex<Element>? {
    vertices.first { $0.value == element }
  }
  
  func addEdge(source: Vertex<Element>, destination: Vertex<Element>, weight: Double) {
    if let existingEdge = source.edgeForDestination(destination) {
      existingEdge.weight = weight
    } else {
      let newEdge = Edge(source: source, destination: destination, weight: weight)
      source.addEdge(newEdge)
    }
  }
  
  func adjacentEdges(for vertex: Vertex<Element>) -> [Edge<Element>] {
    vertex.adjacentEdges
  }
}
