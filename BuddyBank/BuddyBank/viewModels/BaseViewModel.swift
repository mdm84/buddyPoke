//
//  BaseViewModel.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

class BaseViewModel {
  var coordinator: Coordinator?
  let apiManager: APIManager
  
  init(apiManager: APIManager = PokemonApplication.shared.pokemonManager, coordinator: Coordinator) {
    self.coordinator = coordinator
    self.apiManager = apiManager
  }
}
