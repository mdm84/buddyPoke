//
//  PokemonData.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

import Foundation

struct Base: Codable {
  let name: String
  let url: String
}

struct Sprite: Codable {
  let back: String?
  let backF: String?
  let backShiny: String?
  let backShinyF: String?
  let front: String?
  let frontF: String?
  let frontShiny: String?
  let frontShinyF: String?
  let other: Other?

  enum CodingKeys: String, CodingKey {
    case back = "back_default"
    case backF = "back_female"
    case backShiny = "back_shiny"
    case backShinyF = "back_shiny_female"
    case front = "front_default"
    case frontF = "front_female"
    case frontShiny = "front_shiny"
    case frontShinyF = "front_shiny_female"
    case other
  }
}

struct Ability: Codable {
  let slot: Int
  let ability: Base
}

struct Stat: Codable {
  let base: Int
  let effort: Int
  let stat: Base
  
  enum CodingKeys: String, CodingKey {
    case base = "base_stat"
    case effort
    case stat
  }
}

struct Type: Codable {
  let slot: Int
  let type: Base
}

struct Other: Codable {
  let official: Artwork?
  enum CodingKeys: String, CodingKey {
    case official = "official-artwork"
  }
}

struct Artwork: Codable {
  let front: String?
  enum CodingKeys: String, CodingKey {
    case front = "front_default"
  }
}

struct Pokemon: Codable {
  let id: Int
  let name: String
  let abilities: [Ability]
  let experience: Int?
  let height: Int
  let isDefault: Bool
  let location: String?
  let sprites: Sprite?
  let stats: [Stat]
  let weight: Int
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case abilities
    case experience = "base_experience"
    case height
    case isDefault = "is_default"
    case location = "location_area_encounters"
    case sprites
    case stats
    case weight
  }
}
