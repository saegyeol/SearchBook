//
//  NetworkError.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import Foundation

enum NetworkError: Error {
  case invalidURL(url: String)
  case invalidReponse(message: String)
  case invalidSerialize(message: String)
}
