//
//  APIManager.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

class APIManager: PokemonAPIRequestProtocol {
  
  internal let basepath: String
  static var apiResponseQueue: DispatchQueue = .main
  static var requestBuildFactory: RequestBuilderFactory = URLSessionRequestBuilderFactory()
  private let apiServiceRequest: APIServiceRequestProtocol
  
  init(apiServiceRequest: APIServiceRequestProtocol) {
    self.apiServiceRequest = apiServiceRequest
    self.basepath = apiServiceRequest.basepath
  }
  
  private func getPokemonListBuilder(pagination: String? = nil) -> RequestBuilder<PokemonResponse> {
    var urlString = ""
    if let paginationUrlString = pagination {
       urlString = paginationUrlString
    } else {
      let path = "pokemon"
      urlString = basepath + path
    }
    let url = URL(string: urlString)
    let requestBuilder: RequestBuilder<PokemonResponse>.Type = APIManager.requestBuildFactory.getBuilder()
    return requestBuilder.init(method: "GET", urlString: urlString, parameters: url?.queryParameters, isBody: false)
  }
  
  private func getPokemonDetailBuilder(name: String) -> RequestBuilder<Pokemon> {
    let path = "pokemon/" + name
    let urlString = basepath + path
    let requestBuilder: RequestBuilder<Pokemon>.Type = APIManager.requestBuildFactory.getBuilder()
    return requestBuilder.init(method: "GET", urlString: urlString, parameters: nil, isBody: false)
  }
  
  func getPokemon(name: String, completion: @escaping (_ data: Pokemon?, _ error: Error?) -> Void) {
    let builder = getPokemonDetailBuilder(name: name)
    builder.execute(APIManager.apiResponseQueue, apiServiceRequest: apiServiceRequest) { response in
      switch response {
        case let .success(result):
          completion(result.body, nil)
        case let .failure(err):
          completion(nil, err)
      }
    }
  }
  
  func getPokemons(pagination:String? = nil, completion: @escaping (_ data: PokemonResponse?, _ error: Error?) -> Void) {
    let builder = getPokemonListBuilder(pagination: pagination)
    builder.execute(APIManager.apiResponseQueue, apiServiceRequest: apiServiceRequest) { response in
      switch response {
        case let .success(result):
          completion(result.body, nil)
        case let .failure(err):
          completion(nil, err)
      }
    }
  }

  func execute(request: URLRequest, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) { }

}
