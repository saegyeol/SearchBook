//
//  APIClient.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import Foundation

protocol APIClientAble {
  func request(with target: Routable, responseHandler: @escaping (Result<Data, Error>) -> Void)
  func request(with url: URL, responseHandler: @escaping (Result<Data, Error>) -> Void)
}

final class APIClient: APIClientAble {
  static let shared = APIClient(session: URLSession.shared)
  let session: URLSession
  
  private init(session: URLSession) {
    self.session = session
  }
  
  public func request(with target: Routable, responseHandler: @escaping (Result<Data, Error>) -> Void) {
    do {
      let request = try target.asURLRequest()
      let dataTask = self.session.dataTask(with: request) { (data, response, error) in
        guard error == nil else {
          responseHandler(.failure(NetworkError.invalidReponse(message: error!.localizedDescription)))
          return
        }
        guard let data = data else {
           return
        }
        responseHandler(.success(data))
      }
      dataTask.resume()
    } catch {
      responseHandler(.failure(error))
    }
  }
  
  public func request(with url: URL, responseHandler: @escaping (Result<Data, Error>) -> Void) {
    let downloadTask = self.session.dataTask(with: url) { (data, response, error) in
      guard error == nil else {
        responseHandler(.failure(NetworkError.invalidReponse(message: error!.localizedDescription)))
        return
      }
      guard let data = data else {
        return
      }
      responseHandler(.success(data))
    }
    downloadTask.resume()
  }
}
