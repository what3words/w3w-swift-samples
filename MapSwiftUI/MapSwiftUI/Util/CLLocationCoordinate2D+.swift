//
//  CLLocationCoordinate2D+.swift
//  MapSwiftUI
//
//  Created by Dave Duprey on 19/01/2026.
//

//
//  File.swift
//
//
//  Created by Dave Duprey on 08/01/2025.
//

import CoreLocation


// This takes a little explinaiton.  We are defining 4 convenience operators
// here to manipulate CLLocationCoordinate2D.  This is to help draw the little
// what3words logo's slashes in the grid overlay.
// ↑ modifies a CLLocationCoordinate2D and moves it north by the numerical operand
// for example given:
//
// var nulIsland = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
//
// we can do this:
//
// northOfNullIsland = nullIsland ↑ 1.0
//
// resulting in northOfNullIsland equalling (1.0, 0.0)
//
// ↓ → ← similarly move coordinates south, east and west respectively


infix operator ↑ : AdditionPrecedence
infix operator ↓ : AdditionPrecedence
infix operator → : AdditionPrecedence
infix operator ← : AdditionPrecedence


extension CLLocationCoordinate2D {
  
  /// move a coordinate north by some degree
  static public func ↑(left: CLLocationCoordinate2D, right: CLLocationDegrees) -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(
      latitude: left.latitude + right,
      longitude: left.longitude
    )
  }

  
  /// move a coordinate south by some degree
  static public func ↓(left: CLLocationCoordinate2D, right: CLLocationDegrees) -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(
      latitude: left.latitude - right,
      longitude: left.longitude
    )
  }

  
  /// move a coordinate east by some degree
  static public func →(left: CLLocationCoordinate2D, right: CLLocationDegrees) -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(
      latitude: left.latitude,
      longitude: left.longitude + right
    )
  }

  
  /// move a coordinate west by some degree
  static public func ←(left: CLLocationCoordinate2D, right: CLLocationDegrees) -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(
      latitude: left.latitude,
      longitude: left.longitude - right
    )
  }
  
}

