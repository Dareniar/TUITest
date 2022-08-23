//
//  Destination.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import Foundation

final class Destination<Element: Equatable> {
  let vertex: Vertex<Element>
  var previousVertex: Vertex<Element>?
  var totalWeight: Double = Double.infinity
  
  var isReachable: Bool {
    totalWeight < Double.infinity
  }
  
  init(_ vertex: Vertex<Element>) {
    self.vertex = vertex
  }
}
