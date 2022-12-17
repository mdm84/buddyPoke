//
//  APIServiceRequestProtocol.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import Foundation

protocol APIServiceRequestProtocol {
  var basepath: String { get }
  func execute(request: URLRequest, completion: @escaping((Data?, URLResponse?, Error?) -> Void))
}
