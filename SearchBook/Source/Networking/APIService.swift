//
//  APIService.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import Foundation

protocol APIServiceType {
  func search<T: Codable>(query: String, page: Int, completionHandler: @escaping (Result<T, NetworkError>) -> Void)
  func detailBook<T: Codable>(isbn: String, completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}

final class APIService: APIServiceType {
  
  let APIClient: APIClientAble
  
  init(client: APIClientAble) {
    self.APIClient = client
  }
  
  func search<T: Codable>(query: String, page: Int, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
    self.APIClient.request(with: SearchRouter.search(query, page)) { (response) in
      switch response {
      case .success(let data):
        do {
          let result = try JSONDecoder().decode(T.self, from: data)
          completionHandler(.success(result))
        } catch {
          let error = NetworkError(type: NetworkErrorCase.invalidSerialize,
                                   message: "please, check your model \(String(describing: T.self))")
          completionHandler(.failure(error))
        }
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
  
  func detailBook<T: Codable>(isbn: String, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
    self.APIClient.request(with: SearchRouter.bookDetail(isbn)) { (response) in
      switch response {
      case .success(let data):
        do {
          let result = try JSONDecoder().decode(T.self, from: data)
          completionHandler(.success(result))
        } catch {
          let error = NetworkError(type: NetworkErrorCase.invalidSerialize,
                                   message: "please, check your model \(String(describing: T.self))")
          completionHandler(.failure(error))
        }
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
}
