//
//  NetworkError.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import Foundation

enum NetworkErrorCase {
  case invalidURL
  case invalidResponse
  case invalidSerialize
  case invalidData
  case responseDataIsEmpty
  case internalServerError
  case unexpectedError
}

struct NetworkError: Error {
  let type: NetworkErrorCase
  let message: String
  var localizedDescription: String {
    return "\(String(describing: self.type)) reason: \(message)"
  }
}
