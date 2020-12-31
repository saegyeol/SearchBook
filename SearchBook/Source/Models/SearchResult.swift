//
//  SearchResult.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/31.
//

import Foundation

struct SearchResult: Codable {
  let page: Int
  let books: [SimpleBook]
}
