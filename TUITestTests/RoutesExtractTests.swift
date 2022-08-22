//
//  RoutesExtractTests.swift
//  TUITestTests
//
//  Created by Danil on 22.08.2022.
//

import XCTest
@testable import TUITest

final class RoutesExtractTests: XCTestCase {
  func testRoutesExtraction() throws {
    let data = try XCTUnwrap(TestData.responseTextFull.data(using: .utf8))
    let connections = try JSONDecoder().decode(ConnectionsResponse.self, from: data)
    let (cities, routes) = connections.extract()
    XCTAssertEqual(
      cities.map { $0.name }.sorted(by: >),
      ["London", "Tokyo", "Porto", "Sydney", "Cape Town", "New York", "Los Angeles"].sorted(by: >))
    XCTAssertEqual(routes.count, 9)
  }
}
