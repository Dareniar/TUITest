//
//  Vertex.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import Foundation
import CloudKit

final class Vertex<Element: Equatable> {
  var value: Element
  private(set) var adjacentEdges: [Edge<Element>] = []
  
  init(_ value: Element) {
    self.value = value
  }
  
  func addEdge(_ edge: Edge<Element>) {
    self.adjacentEdges.append(edge)
  }
  
  func edgeForDestination(_ destination: Vertex<Element>) -> Edge<Element>? {
    adjacentEdges.filter { $0.destination == destination }.first
  }
}

extension Vertex: Equatable {
  static func == (lhs: Vertex<Element>, rhs: Vertex<Element>) -> Bool {
    lhs.value == rhs.value && lhs.adjacentEdges == rhs.adjacentEdges
  }
}

protocol VertexConvertible: Equatable {
  func toVertex() -> Vertex<Self>
}
