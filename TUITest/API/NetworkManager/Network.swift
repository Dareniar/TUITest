//
//  Network.swift
//  TUITest
//
//  Created by Danil on 22.08.2022.
//

import Foundation
import Combine

protocol Network {
  /// Perform network request
  /// - Parameter url: path of URL from which the data is fetched
  /// - Returns: Publisher of API error or response with expected type
  func fetch<T: Decodable>(request: Request) -> AnyPublisher<T, APIError>
}

final class NetworkManager: Network {
  
  func fetch<T>(request: Request) -> AnyPublisher<T, APIError> where T : Decodable {
    guard let request = request.urlRequest else {
      let error = APIError.network(description: "Couldn't create URL Request")
      return Fail(error: error).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: request)
      .mapError { .network(description: $0.localizedDescription) }
      .flatMap { JSONDecoder().decode($0.data) }
      .eraseToAnyPublisher()
  }
}

