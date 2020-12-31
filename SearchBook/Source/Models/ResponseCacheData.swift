//
//  ResponseCache.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/31.
//

import Foundation

class ResponseCacheData<T: Codable> {

  let response: T
  
  init(response: T) {
    self.response = response
  }
}
