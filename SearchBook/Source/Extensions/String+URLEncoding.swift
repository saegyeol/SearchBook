//
//  String+URLEncoding.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import Foundation

extension String {
  func asEncodedURL() -> URL {
    guard
      let encodedURLString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let url = URL(string: encodedURLString)
      else {
        return URL(string: "about:blank")!
    }
    return url
  }
}
