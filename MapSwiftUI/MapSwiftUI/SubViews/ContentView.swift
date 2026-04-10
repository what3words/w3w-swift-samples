//
//  ContentView.swift
//  MapSwiftUI
//
//  Created by Dave Duprey on 07/01/2026.
//

import SwiftUI
import MapKit
import W3WSwiftCore
import W3WSwiftApi


/// Holds the map and an conditional error message
struct ContentView: View {

  @ObservedObject var viewModel: MapViewModel
  
  /// Holds the map and an conditional error message
  var body: some View {
    ZStack {

      // the map
      MapView(viewModel: viewModel)

      // error message if any
      ErrorView(message: viewModel.message)
    }
  }
  
}


#Preview {
  ContentView(viewModel: MapViewModel(centre: "filled.count.soap", words: ["filled.count.soap"]))
}
