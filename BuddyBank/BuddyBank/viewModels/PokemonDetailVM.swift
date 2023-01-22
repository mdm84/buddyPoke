//
//  PokemonDetailVM.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

final class PokemonDetailVM: BaseViewModel {
  private var elements: [PokemonRow] = PokemonRow.allCases
  
  var rows: Int { elements.count }
  var title: String? { PokemonRow.POKEMON?.name}
  
  func getInfo(at index: Int) -> PokemonRow {
    elements[index]
  }
  
  func assign(_ pokemon: Pokemon) {
    PokemonRow.POKEMON = pokemon
  }
}

enum PokemonRow: Int, CaseIterable {
  static var POKEMON: Pokemon?
  case weight
  case height
  case experience
  case abilities
  case stats
  
  var value: String {
    guard let poke = Self.POKEMON else { return "-" }
    switch self {
      case .weight: return "Weigth: \(poke.weight)"
      case .height: return "Height: \(poke.height)"
      case .experience: return "EXP: \(poke.experience ?? 0)"
      case .abilities:
        let start = poke.abilities.count == 1 ? "Abilitiy:" : "Abilities"
        let val = poke.abilities.map { "•  \($0.ability.name)" }.joined(separator: "\n")
        return start + "\n" + val
      case .stats:
        let start = poke.stats.count == 1 ? "Stat:" : "Stats"
        let val = poke.stats.map { "• \($0.stat.name): Base: \($0.base) - Effort: \($0.effort)" }.joined(separator: "\n")
        return start + "\n" + val
    }
  }
}
