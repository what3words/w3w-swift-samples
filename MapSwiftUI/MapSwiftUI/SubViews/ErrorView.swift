//
//  ErrorView.swift
//  MapSwiftUI
//
//  Created by Dave Duprey on 07/01/2026.
//

import SwiftUI

struct ErrorView: View {
  
  /// The error message, nil if no error
  let message: String?

  
  /// A small view to show any error message
  /// shows nothing if message == nil
  var body: some View {
      VStack {
        if let m = message {
          Text(m)
            .padding()
            .frame(width: 256.0)
            .font(.largeTitle)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(8.0)
        }
      }
    }
}

#Preview {
    ErrorView(message: "error message goes here")
}
