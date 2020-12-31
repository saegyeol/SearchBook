//
//  SearchViewModel.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/31.
//

import Foundation

protocol SearchViewModelType {
  var apiService: APIServiceType { get }
  var simpleBooks: [SimpleBook] { get }
  
  func reset(completion: @escaping () -> Void)
  func search(with query: String, successHandler: @escaping () -> Void, failHandler: @escaping () -> Void)
  func moveToDetail(with index: Int, successHandler: @escaping () -> Void, failHandler: @escaping () -> Void)
}

class SearchViewModel: SearchViewModelType {
  var apiService: APIServiceType
  
  var pageManager: PageManager = PageManager()
  var simpleBooks: [SimpleBook] = []
  
  init(apiService: APIServiceType) {
    self.apiService = apiService
  }
  
  func moveToDetail(with index: Int, successHandler: @escaping () -> Void, failHandler: @escaping () -> Void) {
    let isbn13 = simpleBooks[index].isbn13
    let cacheKey = NSString(string: isbn13)
    if let cacheData = CacheManager.detailBookResponseCache.object(forKey: cacheKey) {
      let detailBook = cacheData.response
      successHandler()
    } else {
      self.apiService.detailBook(isbn: isbn13) { (response: Result<DetailBook, Error>) in
        switch response {
        case .success(let value):
          let cacheData = ResponseCacheData(response: value)
          CacheManager.detailBookResponseCache.setObject(cacheData, forKey: cacheKey)
          dump(value)
          DispatchQueue.main.async {
            successHandler()
          }
        case .failure(let error):
          DispatchQueue.main.async {
            failHandler()
          }
          print(error)
        }
      }
    }
  }
  
  func reset(completion: @escaping () -> Void) {
    self.pageManager = PageManager()
    self.simpleBooks.removeAll()
    DispatchQueue.main.async {
      completion()
    }
  }
  
  func search(with query: String, successHandler: @escaping () -> Void, failHandler: @escaping () -> Void) {
    self.pageManager.progress { (page, done) in
      let cacheKey = NSString(string: query + " page: \(page)")
      if let cacheData = CacheManager.searchResponseCache.object(forKey: cacheKey) {
        self.simpleBooks.append(contentsOf: cacheData.response.books)
        done(cacheData.response.books)
        DispatchQueue.main.async {
          successHandler()
        }
      } else {
        self.apiService.search(query: query, page: page) { (response: Result<SearchResult, Error>) in
          switch response {
          case .success(let value):
            let cacheData = ResponseCacheData(response: value)
            CacheManager.searchResponseCache.setObject(cacheData, forKey: cacheKey)
            self.simpleBooks.append(contentsOf: value.books)
            done(value.books)
            DispatchQueue.main.async {
              successHandler()
            }
          case .failure(let error):
            print(error.localizedDescription)
            DispatchQueue.main.async {
              failHandler()
            }
          }
        }
      }
    }
  }
}
