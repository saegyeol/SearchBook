//
//  APIService.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import Foundation

protocol APIServiceType {
  func search<T: Codable>(query: String, page: Int, completionHandler: @escaping (Result<T, Error>) -> Void)
  func detailBook<T: Codable>(isbn: String, completionHandler: @escaping (Result<T, Error>) -> Void)
  func imageLoad(with url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void)
}

final class APIService: APIServiceType {
  
  let APIClient: APIClientAble
  
  init(client: APIClientAble) {
    self.APIClient = client
  }
  
  func search<T: Codable>(query: String, page: Int, completionHandler: @escaping (Result<T, Error>) -> Void) {
    self.APIClient.request(with: SearchRouter.search(query, page)) { (response) in
      switch response {
      case .success(let data):
        do {
          let result = try JSONDecoder().decode(T.self, from: data)
          completionHandler(.success(result))
        } catch {
          print(error)
          completionHandler(.failure(NetworkError.invalidSerialize(message: error.localizedDescription)))
        }
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
  
  func detailBook<T: Codable>(isbn: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
    self.APIClient.request(with: SearchRouter.bookDetail(isbn)) { (response) in
      switch response {
      case .success(let data):
        do {
          let result = try JSONDecoder().decode(T.self, from: data)
          completionHandler(.success(result))
        } catch {
          print(error)
          completionHandler(.failure(NetworkError.invalidSerialize(message: error.localizedDescription)))
        }
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
  
  func imageLoad(with url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    self.APIClient.request(with: url) { (response) in
      DispatchQueue.main.async {
        completionHandler(response)
      }
    }
  }
}
