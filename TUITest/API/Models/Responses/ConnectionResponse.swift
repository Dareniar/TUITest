//
//  ConnectionResponse.swift
//  TUITest
//
//  Created by Danil on 22.08.2022.
//

import Foundation

struct ConnectionsResponse: Decodable, Equatable {
  let connections: [ConnectionResponse]
  
  /// Extracts lists of cities and available routes from response
  /// - Returns: Array of cities and array of available routes
  func extract() -> ([City], [Route]) {
    var cities = Set<City>()
    var routes = Set<Route>()
    connections.forEach {
      let route = $0.toRoute()
      cities.update(with: route.fromCity)
      cities.update(with: route.toCity)
      routes.update(with: route)
    }
    return (
      Array(cities).sorted(by: { $0.name.lowercased() < $1.name.lowercased() }),
      Array(routes)
    )
  }
}

struct ConnectionResponse: Decodable, Equatable {
  let from: String
  let to: String
  let coordinates: ConnectionCoordinates
  let price: Double
  
  struct ConnectionCoordinates: Decodable, Equatable {
    let from: Coordinates
    let to: Coordinates
  }
  
  fileprivate func toRoute() -> Route {
    let cities = toCities()
    let route = Route(fromCity: cities.0, toCity: cities.1, price: price)
    return route
  }
  
  private func toCities() -> (City, City) {
    let fromCity = City(name: from, coordinates: coordinates.from)
    let toCity = City(name: to, coordinates: coordinates.to)
    return (fromCity, toCity)
  }
}
