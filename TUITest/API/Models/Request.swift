//
//  Request.swift
//  TUITest
//
//  Created by Danil on 22.08.2022.
//

import Foundation

/// Contains list of available API requests
enum Request {
  case connections
  
  var endpoint: String {
    switch self {
    case .connections: return "connections.json"
    }
  }
  
  var url: URL? {
    URL(string: APIConfig.baseURL + endpoint)
  }
  
  var urlRequest: URLRequest? {
    if let url = url {
      return URLRequest(url: url)
    } else {
      return nil
    }
  }
}

fileprivate struct APIConfig {
  static let baseURL = "https://raw.githubusercontent.com/TuiMobilityHub/ios-code-challenge/master/"
}
