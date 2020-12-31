//
//  Router.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import Foundation

enum SearchRouter: Routable {
  case search(String, Int)
  case bookDetail(String)
  
  var host: String {
    "api.itbook.store/1.0/"
  }
  
  var scheme: String {
    "https"
  }
  
  var path: String {
    switch self {
    case .search:
      return "/search"
    case .bookDetail:
      return "/book"
    }
  }
  
  var methods: HttpMethods {
    switch self {
    case .search,
         .bookDetail:
      return .get
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    var urlComponent = URLComponents()
    urlComponent.host = host
    urlComponent.scheme = scheme
    switch self {
    case .search(let query, let page):
      let path = self.path + "/\(query)" + "/\(page)"
      urlComponent.path = path
    case .bookDetail(let isbn13):
      let path = self.path + "/\(isbn13)"
      urlComponent.path = path
    }
    guard let url = urlComponent.url else {
      throw NetworkError.invalidURL(url: urlComponent.host!)
    }
    var request = URLRequest(url: url)
    request.httpMethod = self.methods.rawValue

    return request
  }
}
