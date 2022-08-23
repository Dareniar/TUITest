//
//  RouteFinder.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import Foundation

protocol RouteFindable {
  /// Array of available cities
  var cities: [City] { get }
  /// Array of all available routes
  var routes: [Route] { get }
  /// Method that finds a cheapest route from one city to another
  /// - Parameters:
  ///   - from: Source city
  ///   - to: Destination city
  /// - Returns: A tuple which contains of price of the cheapest route and array of transit cities
  func findCheapestFlight(from: City, to: City) -> (Double?, [City]?)
}

final class RouteFinder: RouteFindable {
  let cities: [City]
  let routes: [Route]
  
  let graph = Graph<City>()
  
  init(cities: [City], routes: [Route]) {
    self.cities = cities
    self.routes = routes
    setupGraph()
  }
  
  func findCheapestFlight(from: City, to: City) -> (Double?, [City]?) {
    guard
      let source = graph.vertex(for: from),
      let destination = graph.vertex(for: to)
    else {
      return (nil, nil)
    }
    
    let dijkstra = Dijkstra(graph: graph, source: source)
    let price = dijkstra.distance(to: destination)
    if let path = dijkstra.path(to: destination) {
      return (price, path.map { $0.value })
    } else {
      return (nil, nil)
    }
  }
  
  private func setupGraph() {
    cities.map { $0.toVertex() }.forEach { graph.addVertex($0) }
    routes.forEach {
      guard
        let source = graph.vertex(for: $0.fromCity),
        let destination = graph.vertex(for: $0.toCity)
      else {
        return
      }
      graph.addEdge(source: source, destination: destination, weight: $0.price)
    }
  }
}
