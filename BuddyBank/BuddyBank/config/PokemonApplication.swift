//
//  PokemonApplication.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

final class PokemonApplication {
  static let shared = PokemonApplication()
  private let base = "https://pokeapi.co/api/v2/"
  private var _urlSession: URLSession?
  var urlSession: URLSession {
    if _urlSession == nil {
      let config = URLSessionConfiguration.default
      config.httpMaximumConnectionsPerHost = 1
      _urlSession = URLSession(configuration: config)
    }
    return _urlSession!
  }
  private lazy var apiServiceRequest: APIServiceRequest = {
    APIServiceRequest(urlSession: urlSession, base: base)
  }()
  private var _pokemonManager: APIManager?
  
  var pokemonManager: APIManager {
    if _pokemonManager == nil {
      _pokemonManager = APIManager(apiServiceRequest: apiServiceRequest)
    }
    return _pokemonManager!
  }
  
}

