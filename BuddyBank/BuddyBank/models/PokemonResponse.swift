//
//  PokeResponse.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

struct PokemonResponse: Codable {
  let count: Int
  let results: [Base]
  let next: String?
}
