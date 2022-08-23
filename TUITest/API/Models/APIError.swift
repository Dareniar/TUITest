//
//  APIError.swift
//  TUITest
//
//  Created by Danil on 22.08.2022.
//

import Foundation

enum APIError: Error {
  case parsing(description: String)
  case network(description: String)
  case search(description: String)
  
  var alertTitle: String {
    switch self {
    case .network: return "Network Error"
    case .parsing: return "Parsing Error"
    case .search: return "Search Error"
    }
  }
  
  var message: String {
    switch self {
    case .parsing(let description), .network(let description), .search(let description):
      return description
    }
  }
}
