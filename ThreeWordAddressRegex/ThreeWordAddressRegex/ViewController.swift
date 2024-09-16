//
//  ViewController.swift
//  ThreeWordAddressRegex
//
//  Created by Dave Duprey on 13/06/2024.
//

import UIKit
import W3WSwiftApi


class ViewController: UIViewController {

  // Initialize the What3Words API with your API key
  let api = What3WordsV4(apiKey: "YourApiKeyGoesHere")

  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.text = ""
    
    check3waFormat()
    searchTextFor3was()
    checkIfReal3wa()
  }


  /// runs the regex to determine if a string matches the form of a three word addres.
  func check3waFormat() {
    self.show(text: "\nChecking address format")
    
    // Example what3words addresses
    let addresses = ["filled.count.soap", "not a 3wa", "not.3wa address"]

    // Check if the addresses are possible what3words addresses
    for address in addresses {
      let isPossible = api.isPossible3wa(text: address)
      self.show(text: "Is '\(address)' a possible what3words address? \(isPossible)")
    }
  }
  
  
  /// search blocks of text to find a three word address in it
  func searchTextFor3was() {
    self.show(text: "\nVerifying addresses are real")

      // Example texts
      let texts = [
          "Please leave by my porch at filled.count.soap",
          "Please leave by my porch at filled.count.soap or deed.tulip.judge",
          "Please leave by my porch at"
      ]

    // Check each text for possible what3words addresses
    for text in texts {
      let possibleAddresses = api.findPossible3wa(text: text)
      self.show(text: "Possible what3words addresses in '\(text)': \(possibleAddresses)")
    }
  }
  
  
  /// verifies if a three word address is a real one
  func checkIfReal3wa() {
    self.show(text: "\nVerifying addresses are real")

    // Example addresses
    let addresses = ["filled.count.soap", "filled.count.", "coding.is.cool"]
    
    // Check if the addresses are valid what3words addresses
    for address in addresses {
      api.isValid3wa(words: address) { result in
        if result == true {
          self.show(text: "'\(address)' is a valid what3words address")
        } else {
          self.show(text: "'\(address)' is NOT a valid what3words address")
        }
      }
    }
  }
  
  
  /// prints text to the console and shows it on the screen
  func show(text: String) {
    print(text)
    
    DispatchQueue.main.async {
      self.textView.text += text + "\n"
    }
  }
  
  
}

