//
//  NetworkManagerMock.swift
//  TUITest
//
//  Created by Danil on 22.08.2022.
//

import Foundation
import Combine

final class NetworkManagerMock: Network {
  private(set) var requests = [Request]()
  private(set) var responses = [Any]()
  
  var response: String?
  
  init(responseString: String) {
    self.response = responseString
  }
  
  func fetch<T>(request: Request) -> AnyPublisher<T, APIError> where T : Decodable {
    requests.append(request)
    
    if let response = response?.data(using: .utf8) {
      responses.append(response)
      return JSONDecoder().decode(response)
    } else {
      let error = APIError.network(description: "Wrong response type")
      responses.append(error)
      return Fail(error: error).eraseToAnyPublisher()
    }
  }
}
