//
//  RequestBuilder.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

class RequestBuilder<T> {
  var headers: [String: String]
  let parameters: [String: Any]?
  let isBody: Bool
  let method: String
  let urlString: String
  
  required init(method: String, urlString: String, parameters: [String: Any]?, isBody: Bool, headers: [String: String] = [:]) {
    self.method = method
    self.urlString = urlString
    self.parameters = parameters
    self.isBody = isBody
    self.headers = headers
  }
  private func addHeaders(_ aHeaders: [String: String]) {
    for (key, value) in aHeaders {
      headers[key] = value
    }
  }
  func execute(_ apiResponseQueue: DispatchQueue, apiServiceRequest: APIServiceRequestProtocol, completion: @escaping(_ result: Result<Response<T>,Error>) -> Void) {}
}
