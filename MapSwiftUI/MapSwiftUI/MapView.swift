//
//  MapView.swift
//  MapSwiftUI
//
//  Created by Dave Duprey on 07/01/2026.
//

import SwiftUI
import MapKit
import W3WSwiftApi

struct MapView: View {
  
  /// The view model for the map view
  @ObservedObject var viewModel: MapViewModel
  
  
  /// Map view showing grid and what3words annotations
  var body: some View {
    MapReader { proxy in
      Map(position: $viewModel.mapCentre) {

        // Draw any grid lines. `viewModel.lines` contains lines when the map is zoomed in far enough
        ForEach(0..<viewModel.lines.count, id: \.self) { index in
          MapPolyline(coordinates: [viewModel.lines[index].start, viewModel.lines[index].end])
            .stroke(.gray.opacity(0.5), lineWidth: 1.0)
        }
        

        // If grid is NOT showing: Draw an anotation for each square in the list
        if !viewModel.showGrid {
          ForEach(Array(viewModel.squares.enumerated()), id: \.offset) { index, square in
            if let words = square.words, let coordinate = square.coordinates {
              Annotation(words, coordinate: coordinate) {
                What3WordsPinView(words: words)
              }
            }
          }

        // If grid IS showing: Draw squares inside the grid lines for each square in the list
        } else {
          ForEach(Array(viewModel.squares.enumerated()), id: \.offset) { index, square in
            if let bounds = square.bounds {
              w3wLogo(bounds: bounds)
            }
          }
        }
      }
      
      // tell the viewModel when the user taps; it will add a pin
      .onTapGesture { location in
        if let coord = proxy.convert(location, from: .local) {
          viewModel.userTapped(at: coord)
        }
      }
      
      // tell the viewModel when the map zooms or scrolls; it will update the grid lines
      .onMapCameraChange(frequency: .onEnd) { context in
        viewModel.update(region: context.region)
      }
    }
  }
  
  
  /// makes a w3w logo square drawn within the lat/long coords of the bounds
  @MapContentBuilder
  func w3wLogo(bounds: W3WBaseBox) -> some MapContent {
    
    // the square
    MapPolygon(coordinates: bounds.asSquarePolygon()).foregroundStyle(.red)
    
    // three slashes
    MapPolygon(coordinates: bounds.slashPolygon(offset: bounds.width * -0.18)).foregroundStyle(.white)
    MapPolygon(coordinates: bounds.slashPolygon(offset: bounds.width *  0.02)).foregroundStyle(.white)
    MapPolygon(coordinates: bounds.slashPolygon(offset: bounds.width *  0.22)).foregroundStyle(.white)
  }
  
}

