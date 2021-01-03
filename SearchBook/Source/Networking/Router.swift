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
    "api.itbook.store"
  }
  
  var scheme: String {
    "https"
  }
  
  var path: String {
    switch self {
    case .search(let query, let page):
      return "/1.0/search/\(query)/\(page)"
    case .bookDetail(let isbn13):
      return "/1.0/books/\(isbn13)"
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
    urlComponent.path = path
    guard let url = urlComponent.url else {
      let error = NetworkError(type: NetworkErrorCase.invalidURL,
                               message: "please, check router")
      throw error
    }
    var request = URLRequest(url: url)
    request.httpMethod = self.methods.rawValue

    return request
  }
}
