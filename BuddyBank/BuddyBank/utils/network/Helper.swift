//
//  Helper.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

class URLSessionRequestBuilderFactory: RequestBuilderFactory {
  func getBuilder<T>() -> RequestBuilder<T>.Type where T : Decodable {
    return URLSessionRequestBuilder<T>.self
  }
}

class URLSessionRequestBuilder<T: Decodable>: RequestBuilder<T> {
  
  required init(method: String, urlString: String, parameters: [String: Any]?, isBody: Bool, headers: [String: String] = [:]) {
    super.init(method: method, urlString: urlString, parameters: parameters, isBody: isBody, headers: headers)
  }
  
  func contentTypeForFormPart(fileURO: URL) -> String? {
    nil
  }
  
  func createURLRequest(method: HTTPMethod, encoding: ParameterEncoding, headers: [String: String]) throws -> URLRequest {
    guard let url = URL(string: urlString) else {
      throw DecodableRequestBuilderError.wrongURL
    }
    var originalRequest = URLRequest(url: url)
    originalRequest.httpMethod = method.rawValue
    headers.forEach { key, value in
      originalRequest.setValue(value, forHTTPHeaderField: key)
    }
    let newRequest = try encoding.encode(originalRequest, parameters: parameters)
    return newRequest
  }
  
  override func execute(_ apiResponseQueue: DispatchQueue, apiServiceRequest: APIServiceRequestProtocol, completion: @escaping(_ result: Result<Response<T>,Error>) -> Void) {
    let encoding: ParameterEncoding
    if isBody {
      encoding = JSONDataEncoding()
    } else {
      encoding = URLEncoding()
    }
    guard let xMethod = HTTPMethod(rawValue: method) else {
      fatalError("Unsupported Http method - \(method)")
    }
    do {
      let request = try createURLRequest(method: xMethod, encoding: encoding, headers: headers)
      apiServiceRequest.execute(request: request) { data, response, error in
        apiResponseQueue.async {
          self.processRequestResponse(urlRequest: request, data: data, response: response, error: error, completion: completion)
        }
      }
    } catch {
      apiResponseQueue.async {
        completion(.failure(ErrorResponse.error(415, nil, error)))
      }
    }
  }
  
  private func processRequestResponse(urlRequest: URLRequest, data: Data?, response: URLResponse?, error: Error?, completion: @escaping(_ result: Result<Response<T>, Error>) -> Void) {
    if let error = error {
      completion(.failure(ErrorResponse.error(-1, data, error)))
    }
    guard let httpResponse = response as? HTTPURLResponse else {
      completion(.failure(DecodableRequestBuilderError.nilHTTPResponse))
      return
    }
    guard  Array(200..<300).contains(httpResponse.statusCode) else {
      completion(.failure(DecodableRequestBuilderError.unsuccessfulHTTPStatusCode))
      return
    }
    switch T.self {
      case is String.Type:
        let body = data.flatMap{ String(data: $0, encoding: .utf8) } ?? ""
        completion(.success(Response<T>(response: httpResponse, body: body as? T)))
      case is Void.Type:
        completion(.success(Response(response: httpResponse, body: nil)))
      case is Data.Type:
        completion(.success(Response(response: httpResponse, body: data as? T)))
      default:
        guard let data = data, !data.isEmpty else{
          completion(.failure(DecodableRequestBuilderError.emptyDataResponse))
          return
        }
        let decodableResult  = Helper.decode(T.self, from: data)
        switch decodableResult {
          case let .success(object):
            completion(.success(Response(response: httpResponse, body: object)))
          case let .failure(error):
            completion(.failure(ErrorResponse.error(httpResponse.statusCode, data, error)))
        }
    }
  }
}

enum HTTPMethod: String {
  case post = "POST"
  case get = "GET"
}

class JSONDataEncoding: ParameterEncoding {
  private static let jsonDataKey = "jsonData"
  func encode(_ urlRequest: URLRequest, parameters: [String : Any]?) throws -> URLRequest {
    var urlRequest = urlRequest
    guard let jsonData = parameters?[JSONDataEncoding.jsonDataKey] as? Data, !jsonData.isEmpty else {
      return urlRequest
    }
    if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    urlRequest.httpBody = jsonData
    return urlRequest
  }
  static func encodingParameters(jsonData: Data?) -> [String: Any]? {
    var returnParams: [String: Any]? = nil
    if let jsonData = jsonData, !jsonData.isEmpty {
      var params: [String: Any] = [:]
      params[jsonDataKey] = jsonData
      returnParams = params
    }
    return returnParams
  }
}

class URLEncoding: ParameterEncoding {
  func encode(_ urlRequest: URLRequest, parameters: [String : Any]?) throws -> URLRequest {
    var urlRequest = urlRequest
    guard let parameters = parameters else { return urlRequest }
    guard let url = urlRequest.url else { throw DecodableRequestBuilderError.wrongURL}
    if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
      urlComponents.queryItems = Helper.mapValuesToQueryItems(parameters)
      urlRequest.url = urlComponents.url
    }
    return urlRequest
  }
}


class Response<T> {
  let statusCode: Int
  let header: [String: String]
  let body: T?
  init(statusCode: Int, header: [String: String], body: T?) {
    self.statusCode = statusCode
    self.header = header
    self.body = body
  }
  convenience init(response: HTTPURLResponse, body: T?) {
    let raw = response.allHeaderFields
    var header = [String: String]()
    for case let (key, value) as (String, String) in raw {
      header[key] = value
    }
    self.init(statusCode: response.statusCode, header: header, body: body)
  }
}

enum ErrorResponse: Error {
  case error(Int, Data?, Error)
}

enum DecodableRequestBuilderError: Error {
  case wrongURL
  case emptyDataResponse
  case nilHTTPResponse
  case fail
  case unsuccessfulHTTPStatusCode
  case jsonDecoding(DecodingError)
  case general(Error)
}

class Helper {
  private static var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    return decoder
  }()
  class func decode<T>(_ type: T.Type, from data: Data) -> Result<T, Error> where T: Decodable {
    let j = Result { try self.decoder.decode(type, from: data)}
    return j
  }
  static func mapValuesToQueryItems(_ source: [String: Any?]) -> [URLQueryItem]? {
    let destination = source.filter({ $0.value != nil }).reduce(into: [URLQueryItem]()) { (result, item) in
      if let collection = item.value as? Array<Any?> {
        let value = collection.filter({ $0 != nil }).map({"\($0!)"}).joined(separator: ",")
        result.append(URLQueryItem(name: item.key, value: value))
      } else if let value = item.value {
        result.append(URLQueryItem(name: item.key, value: "\(value)"))
      }
    }
    if destination.isEmpty {
      return nil
    } else {
      return destination
    }
  }
}
