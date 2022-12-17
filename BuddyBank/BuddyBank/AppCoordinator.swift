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
    let viewModel = PokemonListVM(coordinator: self)
    let firstViewController = PokemonListVC()
    firstViewController.config(with: viewModel)
    navigationController.pushViewController(firstViewController, animated: true)
  }
  
  func pokemonDetail(_ pokemon: Pokemon) {
    let controller = PokemonDetailVC()
    controller.config(pokemon: pokemon)
    navigationController.pushViewController(controller, animated: true)
  }
  
}
