//
//  ViewController.swift
//  OcrComponent
//
//  Created by Dave Duprey on 06/04/2022.
//

import UIKit
import W3WSwiftApi
import W3WSwiftComponentsOcr


class ViewController: UIViewController {

  let api = What3WordsV4(apiKey: "R69YRW4C")
  lazy var ocr = W3WOcrNative(api)
  lazy var ocrViewController = W3WOcrViewController(ocr: ocr)
  
  // scan button
  @IBOutlet weak var scanButton: UIButton!
  
  
  @IBAction func scanButtonPressed(_ sender: Any) {
    // show the OCR ViewController
    self.show(ocrViewController, sender: self)
    
    // start the OCR processing images
    ocrViewController.start()
    
    // when it finds an address, show it in the viewfinder
    ocrViewController.onSuggestions = { [weak self] suggestions in
      if let suggestion = suggestions.first, let words = suggestion.words {
        self?.api.autosuggest(text: words, completion: { [weak self] (suggestions, error) in
          DispatchQueue.main.async {
            self?.ocrViewController.insertMoreAutoSuggestions(suggestions ?? [])
          }
        })
      }
      // Or, maybe stop on result
      //self?.ocrViewController.stop()
    }

    // if there is an error show the u ser
    ocrViewController.onError = { [weak self] error in
      self?.ocrViewController.stop()
      self?.showError(error: error)
    }
  }
  
  
  /// display an error using a UIAlertController, error messages conform to CustomStringConvertible
  func showError(error: Error) {
    DispatchQueue.main.async { [weak self] in
      let alert = UIAlertController(title: "Error", message: String(describing: error), preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      self?.ocrViewController.present(alert, animated: true)
    }
  }
  
}

