//
//  AppCoordinator.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import UIKit

class AppCoordinator: Coordinator {
  var parentCoordinator: Coordinator?
  var children: [Coordinator] = []
  var navigationController: UINavigationController
  
  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func startApp() {
    
  }
  
}
