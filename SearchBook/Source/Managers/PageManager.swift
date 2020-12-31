//
//  PageManager.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/31.
//

import Foundation

class PageManager {
  public var page = 1
  private var isPagable = true

  func progress(taskBlock: (_ page: Int, _ done: @escaping ([Any]) -> Void) -> Void) {
    if isPagable {
      isPagable = false

      taskBlock(page) { array in
        //  is available paging
        if !array.isEmpty {
          self.page = self.page + 1
          self.isPagable = true
        }
      }
    }
  }
}
