//
//  SearchRouteView.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import SwiftUI

struct SearchRouteView: View {
  @ObservedObject var viewModel: SearchRouteViewModel
        
  init(viewModel: SearchRouteViewModel = .init()) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 16) {
      fromTextField
      toTextField
      searchButton
      Spacer()
    }
    .padding()
    .alert(isPresented: $viewModel.showError) {
      errorAlert
    }
  }
}

private extension SearchRouteView {
  
  var fromTextField: some View {
    VStack(alignment: .leading) {
      Text("From")
        .font(.footnote)
      TextField("Tap here to select the departure", text: $viewModel.fromCityText)
        .textFieldStyle(.roundedBorder)
        .allowsHitTesting(false)
        .popover(isPresented: $viewModel.showFromCityPopup, arrowEdge: .bottom) {
          SelectCityView(selection: $viewModel.fromCity, cities: viewModel.cities)
        }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      viewModel.showFromCityPopup = true
    }
  }
  
  var toTextField: some View {
    VStack(alignment: .leading) {
      Text("To")
        .font(.footnote)
      TextField("Tap here to select the arrival", text: $viewModel.toCityText)
        .allowsHitTesting(false)
        .textFieldStyle(.roundedBorder)
        .popover(isPresented: $viewModel.showToCityPopup, arrowEdge: .bottom) {
          SelectCityView(selection: $viewModel.toCity, cities: viewModel.cities)
        }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      viewModel.showToCityPopup = true
    }
  }
  
  var searchButton: some View {
    Button {
      viewModel.searchPath()
      print(viewModel.path)
    } label: {
      Text("Search the cheapest route")
    }
    .buttonStyle(.borderedProminent)
    .disabled(!viewModel.isSearchAvailable)
  }
  
  var errorAlert: Alert {
    let error = viewModel.error ?? .network(description: "")
    return Alert(
      title: Text(error.alertTitle),
      message: Text(error.message),
      primaryButton: .default(Text("Cancel")),
      secondaryButton: .cancel(Text("Retry"), action: {
        viewModel.loadRoutes()
      })
    )
  }
}

struct SearchRouteView_Previews: PreviewProvider {
  static var previews: some View {
    SearchRouteView()
  }
}
