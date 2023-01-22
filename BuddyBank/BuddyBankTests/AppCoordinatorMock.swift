//
//  AppCoordinatorMock.swift
//  BuddyBankTests
//
//  Created by Max on 22/01/23.
//

import UIKit
@testable import BuddyBank

class AppCoordinatorMock: Coordinator {
  var parentCoordinator: BuddyBank.Coordinator?
  var children: [BuddyBank.Coordinator] = []
  var navigationController: UINavigationController
  
  var pokemon: Pokemon?
  var hasNavigationController: Bool = false
  var hasStarted: Bool = false
  
  init() {
    navigationController = UINavigationController()
    hasNavigationController = true
  }
  
  func startApp() {
    hasStarted = true
  }
  
  func pokemonDetail(_ pokemon: Pokemon) {
    self.pokemon = pokemon
  }
}
