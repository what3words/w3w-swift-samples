//
//  W3WBaseBox+.swift
//  MapSwiftUI
//
//  Created by Dave Duprey on 15/01/2026.
//

import MapKit
import W3WSwiftCore


public extension W3WBaseBox {
  
  /// To convert between a MKCoordinateRegion and a W3WBox
  init(region: MKCoordinateRegion) {
    self.init(
      southWest: CLLocationCoordinate2D(
        latitude: region.center.latitude - region.span.latitudeDelta,
        longitude: region.center.longitude - region.span.longitudeDelta
      ),
      northEast: CLLocationCoordinate2D(
        latitude: region.center.latitude + region.span.latitudeDelta,
        longitude: region.center.longitude + region.span.longitudeDelta
      )
    )
  }
  
  
  var northWest: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: northEast.latitude, longitude: southWest.longitude)
  }
  
  var southEast: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: southWest.latitude, longitude: northEast.longitude)
  }
  
  
  var width: CLLocationDegrees {
    return abs(northEast.longitude - southWest.longitude)
  }
  
  
  var height: CLLocationDegrees {
    return abs(northEast.longitude - southWest.longitude)
  }
  
  
  func asSquarePolygon() -> [CLLocationCoordinate2D] {
    return [northWest, northEast, southEast, southWest]
  }
  
  
  /// Return coordinate polygons to draw a what3words logo slash
  func slashPolygon(offset: CLLocationDegrees) -> [CLLocationCoordinate2D] {
    let thick  = width * 0.025
    let slant  = width * 0.065
    let inset  = width * 0.165
    let middle = width * 0.5

    // The wierd ↓ ↑ → ← symbols here are custom operators defined in
    // CLLocationCoordinate2D+.swift, they add or subtrace a value to
    // a coordinate. Think of them as North South East West operators
    return [
      southWest ↑ inset → middle ← thick ← slant ← offset,
      southWest ↑ inset → middle → thick ← slant ← offset,
      northEast ↓ inset ← middle → thick → slant ← offset,
      northEast ↓ inset ← middle ← thick → slant ← offset
    ]
  }
  
}
