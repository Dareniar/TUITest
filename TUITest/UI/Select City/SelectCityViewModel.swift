//
//  SelectCityViewModel.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import SwiftUI
import Combine

final class SelectCityViewModel: ObservableObject {
  
  @Published var filterQuery = ""
  @Published var cities: [City]
  
  let allCities: [City]
  
  private var disposables = Set<AnyCancellable>()
  
  init(cities: [City], scheduler: DispatchQueue = DispatchQueue(label: "SearchQueue")) {
    self.allCities = cities
    self.cities = allCities
    
    $filterQuery
      .dropFirst(1)
      .debounce(for: .seconds(0.2), scheduler: scheduler)
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] _ in
        guard let query = self?.filterQuery, !query.isEmpty else {
          self?.cities = self?.allCities ?? []
          return
        }
        self?.cities = self?.allCities.filter { $0.name.lowercased().contains(query.lowercased())} ?? []
      })
      .store(in: &disposables)
  }
}
