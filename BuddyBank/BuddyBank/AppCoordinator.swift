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
    let vm = PokemonDetailVM(coordinator: self)
    vm.assign(pokemon)
    controller.config(viewModel: vm)
    navigationController.pushViewController(controller, animated: true)
  }
  
}
