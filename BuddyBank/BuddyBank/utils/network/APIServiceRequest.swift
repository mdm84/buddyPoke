//
//  APIServiceRequest.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

final class APIServiceRequest: APIServiceRequestProtocol {
  private let baseUrl: String
  private let urlSession: URLSession

  private var headers: [String: String] {
    [
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
  }
  
  var basepath: String { baseUrl }
  
  init(urlSession: URLSession, base: String) {
    self.urlSession = urlSession
    self.baseUrl = base
  }
  
  func execute(request: URLRequest, completion: @escaping((Data?, URLResponse?, Error?) -> Void)) {
    var mutableRequest = request
    for (key, value) in headers {
      mutableRequest.addValue(value, forHTTPHeaderField: key)
    }
    mutableRequest.httpShouldHandleCookies = true
    urlSession.dataTask(with: mutableRequest, completionHandler: { data, response, error in
      completion(data, response, error)
    }).resume()
  }
}
