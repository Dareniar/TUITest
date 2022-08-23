//
//  SearchRouteViewModel.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import SwiftUI
import Combine

final class SearchRouteViewModel: ObservableObject {
  // MARK: - Properties
  @Published var fromCity: City? {
    didSet {
      handleCitySelection()
    }
  }
  @Published var toCity: City? {
    didSet {
      handleCitySelection()
    }
  }
  
  private(set) var error: APIError?
  @Published var showError: Bool = false
  
  @Published var showFromCityPopup = false
  @Published var showToCityPopup = false
  
  @Published var toCityText = ""
  @Published var fromCityText = ""
  
  @Published private(set) var price: Double?
  @Published private(set) var path: [City]?
  
  private(set) var isSearchAvailable = false
  
  private let network: Network
  
  private(set) var cities = [City]()
  private var routes = [Route]()
  
  private var disposables = Set<AnyCancellable>()
  
  // MARK: - Public Methods
  
  init(network: Network = NetworkManager()) {
    self.network = network
    loadRoutes()
  }
    
  func loadRoutes() {
    network.fetch(request: .connections)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] value in
        switch value {
        case .failure(let error):
          self?.error = error
          self?.showError = true
        case .finished:
          break
        }
      } receiveValue: { [weak self] (response: ConnectionsResponse) in
        let (cities, routes) = response.extract()
        self?.cities = cities
        self?.routes = routes
      }
      .store(in: &disposables)
  }
  
  func searchPath() {
    guard
      isSearchAvailable,
      let toCity = toCity,
      let fromCity = fromCity
    else {
      return
    }
    
    let routeFinder = RouteFinder(cities: cities, routes: routes)
    (price, path) = routeFinder.findCheapestFlight(from: fromCity, to: toCity)
    
    if price == nil || path == nil {
      error = .search(description: "Ooops... For selected source and destination we can't find any flights :(")
      showError = true
    }
  }
  
  // MARK: - Private Methods
  private func searchCity(by name: String) -> [City] {
    cities.filter { $0.name.lowercased().contains(name.lowercased()) }
  }
  
  private func handleCitySelection() {
    isSearchAvailable = fromCity != nil && toCity != nil && fromCity != toCity
    toCityText = toCity?.name ?? ""
    fromCityText = fromCity?.name ?? ""
    
    showToCityPopup = false
    showFromCityPopup = false
  }
}
