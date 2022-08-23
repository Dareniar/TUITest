//
//  SelectCityView.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import SwiftUI

struct SelectCityView: View {
  @Binding var selection: City?
  @ObservedObject var viewModel: SelectCityViewModel
    
  init(selection: Binding<City?>, cities: [City]) {
    self.viewModel = SelectCityViewModel(cities: cities)
    self._selection = selection
  }
  
  var body: some View {
    List {
      TextField("Filter cities by name", text: $viewModel.filterQuery)
      Section {
        ForEach(viewModel.cities) { city in
          HStack {
            Text(city.name)
            Spacer()
          }
          .contentShape(Rectangle())
          .onTapGesture {
            selection = city
          }
        }
      }
    }
    .frame(minWidth: 300, minHeight: 400)
  }
}

struct SelectCityView_Previews: PreviewProvider {
  static var previews: some View {
    SelectCityView(selection: .constant(nil), cities: [
      City(name: "London", coordinates: .init(lat: 0, long: 0)),
      City(name: "Paris", coordinates: .init(lat: 0, long: 0)),
      City(name: "Tokyo", coordinates: .init(lat: 0, long: 0))
    ])
  }
}
