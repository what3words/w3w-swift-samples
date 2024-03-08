//
//  ViewController.swift
//  TextField
//
//  Created by Dave Duprey on 26/11/2020.
//

import UIKit
import W3WSwiftApi
import W3WSwiftComponents


class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // make the API
    let apiKey = "YourApiKey"
    let api = What3WordsV4(apiKey: apiKey)

    // make the text field
    let textField = W3WAutoSuggestTextField(frame: CGRect(x: 16.0, y: (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 64.0) + 16.0, width: view.frame.size.width - 32.0, height: 32.0))
    
    // assign the API to it
    textField.set(api)

    // turn on voice support
    textField.set(voice: true)

    // assign a code block to execute when the user has selected an address
    textField.onSuggestionSelected = { suggestion in
      print("User chose:", suggestion.words ?? "")
    }

    // the exact error can be captured using onError for whatever purpose you might have
    textField.onError = { error in
      self.showError(error: error)
    }
    
    // place in the view
    view.addSubview(textField)
  }

  
  
  /// display an error using a UIAlertController, error messages conform to CustomStringConvertible
  func showError(error: Error) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: "Error", message: String(describing: error), preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      self.present(alert, animated: true)
    }
  }

}

