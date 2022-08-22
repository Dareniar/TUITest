//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Danil on 22.08.2022.
//

import XCTest
import Combine
@testable import TUITest

final class NetworkManagerTests: XCTestCase {
  
  private let manager = NetworkManagerMock(responseString: TestData.responseTextShort)
  
  private var disposables = Set<AnyCancellable>()
  
  func testShouldReturnValue() {
    let connections = ConnectionsResponse(connections: [
      ConnectionResponse(
        from: "London",
        to: "Tokyo",
        coordinates: .init(
          from: .init(lat: 51.5285582, long: -0.241681),
          to: .init(lat: 35.652832, long: 139.839478)
        ),
        price: 220
      ),
      ConnectionResponse(
        from: "Tokyo",
        to: "London",
        coordinates: .init(
          from: .init(lat: 35.652832, long: 139.839478),
          to: .init(lat: 51.5285582, long: -0.241681)
        ),
        price: 200
      )
    ])
    manager.fetch(request: .connections)
      .sink { value in
        switch value {
        case .failure(let error):
          XCTFail(error.localizedDescription)
        case .finished:
          break
        }
      } receiveValue: {
        XCTAssertEqual(connections, $0)
      }
      .store(in: &disposables)
    
    XCTAssertEqual(manager.responses.last as? Data, TestData.responseTextShort.data(using: .utf8))
  }
  
  func testNoDataError() {
    manager.response = nil
    manager.fetch(request: .connections)
      .sink { value in
        switch value {
        case .failure(let error):
          XCTAssertEqual(error.message, "Wrong response type")
        case .finished:
          XCTFail()
          break
        }
      } receiveValue: { (response: ConnectionsResponse) in
        XCTFail("There shouldn't be any response")
      }
      .store(in: &disposables)
  }
  
  func testShouldReturnParsingError() {
    manager.response = TestData.responseTextShort
    
    manager.fetch(request: .connections)
      .sink { value in
        switch value {
        case .failure(let error):
          XCTAssertEqual(error.message, "The data couldn’t be read because it is missing.")
        case .finished:
          XCTFail()
          break
        }
      } receiveValue: { (response: Coordinates) in
        XCTFail("There shouldn't be any response")
      }
      .store(in: &disposables)
  }
}
