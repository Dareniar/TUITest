//
//  Edge.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import Foundation

final class Edge<Element: Equatable> {
  var source: Vertex<Element>
  var destination: Vertex<Element>
  var weight: Double
  
  init(source: Vertex<Element>, destination: Vertex<Element>, weight: Double) {
    self.source = source
    self.destination = destination
    self.weight = weight
  }
}

extension Edge: Equatable {
  static func == (lhs: Edge<Element>, rhs: Edge<Element>) -> Bool {
    lhs.source == rhs.source && lhs.destination == rhs.destination && lhs.weight == rhs.weight
  }
}

protocol EdgeConvertible {
  associatedtype Element: Equatable
  
  func toEdge() -> Edge<Element>
}

