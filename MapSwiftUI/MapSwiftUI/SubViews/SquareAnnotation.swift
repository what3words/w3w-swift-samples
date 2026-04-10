//
//  SquareAnnotation.swift
//  MapSwiftUI
//
//  Created by Dave Duprey on 07/01/2026.
//

import SwiftUI
import MapKit


struct What3WordsPinView: View {
  
  /// The three word address to show
  let words: String
  
  /// A view used for the annotation pin
  /// shows three white slashes in a red circle
  var body: some View {
    ZStack {
      
      // background circle
      Circle()
        .frame(width: 30, height: 30)
        .foregroundColor(.red)
        .cornerRadius(2.0)
      
      // three shashes to show in circle
      Text("///")
        .foregroundColor(.white)
        .padding(.bottom, 3.0)
    }
    
      // optionally we can do something if the annotation is tapped
      .highPriorityGesture(
        TapGesture()
          .onEnded {
            print("Tapped on the " + words + " annotation")
          }
      )
  }
}


#Preview {
  What3WordsPinView(words: "word.word.word")
}
