//
//  URL+QueryParam.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

extension URL {
  public var queryParameters: [String: String]? {
    guard
      let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
      let queryItems = components.queryItems else { return nil }
    return queryItems.reduce(into: [String: String]()) { (result, item) in
      result[item.name] = item.value
    }
  }
}
