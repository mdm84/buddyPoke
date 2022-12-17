//
//  AppDelegate.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var appCoordinator: AppCoordinator?
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    let navigationController = UINavigationController()
    appCoordinator = AppCoordinator(with: navigationController)
    appCoordinator?.startApp()
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return true
  }


}

