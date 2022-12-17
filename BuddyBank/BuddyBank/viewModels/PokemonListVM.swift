//
//  PokemonListVM.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

final class PokemonListVM: BaseViewModel {
  private var canLoad = true
  private var currentResponse: PokemonResponse?
  private var delegate: PokemonListViewModelProtocol?
  private var pokemons: [Pokemon] = [] {
    didSet {
      delegate?.fetch(nil)
    }
  }
  private(set) var initialFrame: Int?
  private(set) var endFrame: Int?
  
  var count: Int { pokemons.count }
  
  func pokemon(at indexPath: IndexPath) -> Pokemon {
    pokemons[indexPath.item]
  }
  
  func setPokemon(delegate: PokemonListViewModelProtocol?){
    self.delegate = delegate
  }
  
  //MARK: API
  func pokemonList() {
    guard canLoad == true else { return }
    canLoad = false
    if let resp = currentResponse, resp.next == nil {
      return
    }
    let group = DispatchGroup()
    var list: [Pokemon] = []
    apiManager.getPokemons(pagination: currentResponse?.next) { [self] (response, error) in
      if error == nil {
        self.currentResponse = response
        for baseData in response?.results ?? [] {
          group.enter()
          self.apiManager.getPokemon(name: baseData.name) { (pokemon, error) in
            if error == nil {
              if let p = pokemon {
                list.append(p)
              }
            }
            group.leave()
          }
        }
      } else {
        self.delegate?.fetch(error)
      }
      group.notify(queue: DispatchQueue.main) {
        self.initialFrame = self.count
        self.endFrame = self.count + list.count - 1
        self.pokemons += list
        self.canLoad = true
      }
    }
  }
   
  //MARK: Navigation
  func showDetail(by indexPath: IndexPath) {
    coordinator?.pokemonDetail(pokemon(at: indexPath))
  }
  
}
