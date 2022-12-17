//
//  BaseViewModel.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

class BaseViewModel {
  weak var coordinator: AppCoordinator?
  let apiManager: APIManager
  
  init(apiManager: APIManager = PokemonApplication.shared.pokemonManager, coordinator: AppCoordinator) {
    self.coordinator = coordinator
    self.apiManager = apiManager
  }
}
