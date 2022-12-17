//
//  RequestBuildFactory.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

protocol ParameterEncoding {
  func encode(_ urlRequest: URLRequest, parameters: [String: Any]?) throws -> URLRequest
}

protocol RequestBuilderFactory {
  func getBuilder<T:Decodable>() -> RequestBuilder<T>.Type
}
