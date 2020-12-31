//
//  DetailBook.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/31.
//

import Foundation

struct DetailBook: Codable {
  let title: String
  let subtitle: String
  let authors: String
  let publisher: String
  let isbn10: String
  let isbn13: String
  let pages: String
  let year: String
  let rating: String
  let desc: String
  let price: String
  let image: String
  let url: String
}
