//
//  ViewController.swift
//  OcrComponent
//
//  Created by Dave Duprey on 21/05/2024.
//

import UIKit
import W3WSwiftApi
import W3WSwiftComponentsOcr
import W3WSwiftDesign


/// Start View Controller is a convenience controller for launching the component
/// which includes a callback that respondes to a user pressing "Start Scanning"
class ViewController: W3WOcrStartViewController {
  
  /// the what3words API
  lazy var api = What3WordsV4(apiKey: "YourApiKey") // sign up for an api key here: https://developer.what3words.com/public-api

  /// the what3words OCR word rcogniser
  lazy var ocr = W3WOcrNative(api)
  
  
  /// Show and start the OCR component, this function is called
  /// by a button on the root view (see viewDidLoad() below)
  /// Use a function like this to make, show, and run the OCR
  func launchOcr() {
    
    // make the component
    let ocrViewController = W3WOcrViewController(ocr: ocr, theme: .what3words, w3w: api)
    
    // show the component
    present(ocrViewController, animated: true)
    
    // start the component
    ocrViewController.start()
    
    // when the user taps on a suggestion, stop and dismiss the component
    ocrViewController.onSuggestionSelected = { [weak self] suggestion in
      self?.notify(title: "Result:", message: suggestion.description)
      
      ocrViewController.stop()
      ocrViewController.dismiss(animated: true)
    }
    
    ocrViewController.onError = { error in
      print(error)
    }
  }
  

  // set up a simple view with a start button
  override public func viewDidLoad() {
    super.viewDidLoad()

    // Sets the theme.  You can make custom `W3WTheme`s to adjust colours and styles to suit, or start with standard and modify
    set(theme: .standard.with(background: W3WColor(light: .white, dark: .black)))
    
    // launch the ocr component when the button is pressed
    onButtonPressed = { [weak self] in
      self?.launchOcr()
    }
  }


  // MARK: - Popup Message
  
  
  func notify(title: String, message: String) {
    DispatchQueue.main.async { [weak self] in
      let note = UIAlertController(title: title, message: message, preferredStyle: .alert)
      note.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { _ in }))
      self?.present(note, animated: true) { }
    }
  }
  
}
