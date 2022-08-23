//
//  FindRouteTests.swift
//  TUITestTests
//
//  Created by Danil on 23.08.2022.
//

import XCTest
@testable import TUITest

final class FindRouteTests: XCTestCase {
  
  var cities: [City]!
  var routes: [Route]!
  
  override func setUpWithError() throws {
    let data = try XCTUnwrap(TestData.responseTextFull.data(using: .utf8))
    let connectionsResponse = try JSONDecoder().decode(ConnectionsResponse.self, from: data)
    let connections = connectionsResponse.extract()
    self.cities = connections.0
    self.routes = connections.1
  }
  
  func testLondonSydneyPrice() throws {
    let finder = RouteFinder(cities: cities, routes: routes)
    
    let london = try XCTUnwrap(cities.first(where: { $0.name == "London"}))
    let tokyo = try XCTUnwrap(cities.first(where: { $0.name == "Tokyo"}))
    let sydney = try XCTUnwrap(cities.first(where: { $0.name == "Sydney"}))
    
    let predictedRoutes = [london, tokyo, sydney]
    let predictedPrice = 320.0
    
    let result = finder.findCheapestFlight(from: london, to: sydney)
    
    XCTAssertEqual(result.0, predictedPrice)
    XCTAssertEqual(result.1, predictedRoutes)
  }
}
