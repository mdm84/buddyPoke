//
//  PokemonAPIProtocol.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

protocol PokemonAPIRequestProtocol: APIServiceRequestProtocol {
  func getPokemon(name: String, completion: @escaping(_ data: Pokemon?, _ error: Error?) -> Void)
  func getPokemons(pagination: String?, completion: @escaping(_ data: PokemonResponse?, _ error: Error?) -> Void)
}
