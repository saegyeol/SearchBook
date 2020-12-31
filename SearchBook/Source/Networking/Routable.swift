//
//  Routable.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import Foundation

protocol Routable {
  func asURLRequest() throws -> URLRequest
}

enum HttpMethods: String {
  case get = "get"
}
