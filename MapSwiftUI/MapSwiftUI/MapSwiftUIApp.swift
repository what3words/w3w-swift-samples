//
//  MapSwiftUIApp.swift
//  MapSwiftUI
//
//  Created by Dave Duprey on 07/01/2026.
//

import SwiftUI


@main
struct MapSwiftUIApp: App {

  // The data model for the app
  let viewModel = MapViewModel(
    
    // set the map centre to ///filled.count.soap
    centre: "filled.count.soap",
    
    // show some annotations at various three word addresses
    words: [
      "filled.count.soap",
      "index.home.raft",
      "melt.light.parent",
      "input.vase.feels"
    ]
  )

  
  // the views
  var body: some Scene {
    
    WindowGroup {
      
      // holds the map view and error message view
      ContentView(viewModel: viewModel)
      
    }
  }
  
}
