//
//  SuggestionView.swift
//  AutosuggestExampleSwiftUI
//
//  Created by Dave Duprey on 13/09/2021.
//

import SwiftUI
import W3WSwiftCore
import W3WSwiftApi


/// a row for a list showing a W3WSuggestioin
struct SuggestionView: View {

  var suggestion: W3WSuggestion
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("///").foregroundColor(.red) + Text((suggestion.words ?? ""))
        HStack {
          Text((suggestion.nearestPlace ?? "") + ", " + (suggestion.country?.code ?? ""))
            .font(.footnote)
          if let kilometers = suggestion.distanceToFocus?.kilometers {
            Spacer()
            Text(String(format:"%.0fkm", kilometers))
              .font(.footnote)
          }
        }
      }
      Spacer()
    }
    .contentShape(Rectangle())
  }
}


struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
      SuggestionView(suggestion: W3WApiSuggestion(words: "filled.count.soap", nearestPlace: "Bayswater", distanceToFocus: 42.0))
    }
}
