//
//  SceneDelegate.swift
//  OcrComponent
//
//  Created by Dave Duprey on 06/04/2022.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: scene)

    let viewController = ViewController()

    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
  }

}

