//
//  City.swift
//  TUITest
//
//  Created by Danil on 22.08.2022.
//

import Foundation

struct City: Hashable {
  let name: String
  let coordinates: Coordinates
}

extension City: VertexConvertible {
  func toVertex() -> Vertex<City> {
    Vertex(self)
  }
}
