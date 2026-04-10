//
//  Model.swift
//  MapSwiftUI
//
//  Created by Dave Duprey on 15/01/2026.
//

import Combine
import SwiftUI
import MapKit
import W3WSwiftApi
import W3WSwiftCore


class MapViewModel: ObservableObject {
  
  // MARK: API
  
  /// The what3words API, get your API key here: https://developer.what3words.com/public-api
  let api = What3WordsV4(apiKey: "YouApiKeyGoesHere")


  // MARK: Vars published to the map view
  
  /// A list of squares to show as annotations on the map
  @Published var squares = [W3WSquare]()
  
  /// A list of gridlines to show on the map to show all the squares
  @Published var lines: [W3WLine] = []
  
  /// The centre of the map in the view
  @Published var mapCentre = MapCameraPosition.region(MKCoordinateRegion( center: CLLocationCoordinate2D(latitude: 51.520847, longitude: -0.195521), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)))

  /// An error message if needed
  @Published var message: String?

  
  // MARK: Local vars
  
  /// holds the last known latitude delta of the map, and sets the starting span
  var latitudeDelta = 0.03

  /// A default span to start the map view at
  lazy var span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: latitudeDelta)
  
  /// Calulate if grid should show - basically if the map view latitude delta 0.001
  /// The API will return an error if a grid larger than 4 kilometers is requested
  var showGrid: Bool {
    return latitudeDelta < 0.001
  }
  
  
  /// Set initial conditions with the centre of the map
  /// and some annotations using three word addresses
  init(centre: String, words: [String]) {
    // set the map centre, and show the three word addresses
    set(centre: centre)
    show(words: words)
  }
  

  /// Called when the user taps the map. Given a lat/long coordinate,
  /// convert it to a square and add it to the annotaions list
  func userTapped(at: CLLocationCoordinate2D) {
    api.convertTo3wa(coordinates: at, language: W3WBaseLanguage(locale: "en")) { square, error in
      self.showErrorIfAny(error: error)
      print("User tapped " + (square?.words ?? ""))
      
      // add the square
      self.add(square: square)
    }
  }

  
  /// Given an array of three word address strings, convert each to
  /// a `square` and update the array of `squares`
  func show(words: [String]) {
    
    // go through all three word addresses
    for word in words {
    
      // convert each word to a square
      api.convertToCoordinates(words: word) { square, error in
        self.showErrorIfAny(error: error)
        
        // add the square
        self.add(square: square)
      }
    }

  }
  
  
  /// This is called by the map when the map view changes.
  /// Convert region to W3WBaseBox and call update(area:) to update the grid.
  /// Also remember the latitude delta of the map - we use this to determine if we are zoomed in enough to show the grid
  func update(region: MKCoordinateRegion) {
    latitudeDelta = region.span.latitudeDelta
    
    // if we ae zoomed in enough show the grid, make lines - this depends on `latitudeDelta`
    if showGrid {
      updateGrid(area: W3WBaseBox(region: region))

    // otherwise, no lines
    } else {
      lines = []
    }
  }
  
  
  /// Given a three word address in a String, make that the centre of the map
  func set(centre: String) {

    // call the API
    api.convertToCoordinates(words: centre) { square, error in
      self.showErrorIfAny(error: error)
        
      // set the map centre
      if let coordinates = square?.coordinates {
        self.set(centre: coordinates)
      }
    }
  }
  
  
  /// Given a lat/long, make that the centre of the map
  func set(centre: CLLocationCoordinate2D) {
    DispatchQueue.main.sync {
      self.mapCentre = MapCameraPosition.region(MKCoordinateRegion(center: centre, span: self.span))
    }
  }

  
  /// Get new grid from the API, and assign it to `lines`.
  /// In this example app, this call only happens when the user
  /// finishes zooming or scrolling. Be careful to debounce this call
  /// if your code calls it too often, for example during scolling.
  /// Debouncing is left out here to simplify the code, and because
  /// it is called sparingly.
  func updateGrid(area: W3WBaseBox) {
    api.gridSection(bounds: area) { grid, error in
      self.showErrorIfAny(error: error)

      DispatchQueue.main.sync {
        self.lines = grid ?? []
      }
    }
  }

  
  /// Add an annotation to the map at a particular square
  func add(square: W3WSquare?) {
    if let s = square {
      DispatchQueue.main.sync {
        self.squares.append(s)
      }
    }
  }
  
  
  /// If the error passed in is not `nil`, then we show the message on the screen
  func showErrorIfAny(error: W3WError?) {
    if let e = error {
      DispatchQueue.main.sync {
        self.message = e.description
      }
    }
  }

}
