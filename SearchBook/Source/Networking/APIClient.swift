//
//  APIClient.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import UIKit

protocol APIClientAble {
  func request(with target: Routable, responseHandler: @escaping (Result<Data, Error>) -> Void)
  func downloadImage(with url: URL, responseHandler: @escaping (Result<UIImage, Error>) -> Void)
}

final class APIClient: APIClientAble {
  static let shared = APIClient(session: URLSession.shared)
  private let session: URLSession
  
  private init(session: URLSession) {
    self.session = session
  }
  
  public func request(with target: Routable, responseHandler: @escaping (Result<Data, Error>) -> Void) {
    do {
      let request = try target.asURLRequest()
      let key = request.url!.absoluteString
      if let cacheData = CacheManager.responseObject(forKey: key) {
        responseHandler(.success(cacheData))
      } else {
        let dataTask = self.session.dataTask(with: request) { (data, response, error) in
          guard error == nil else {
            responseHandler(.failure(NetworkError.invalidReponse(message: error!.localizedDescription)))
            return
          }
          guard let data = data else {
             return
          }
          CacheManager.setObject(response: data, forKey: key)
          responseHandler(.success(data))
        }
        dataTask.resume()
      }
    } catch {
      responseHandler(.failure(error))
    }
  }
  
  public func downloadImage(with url: URL, responseHandler: @escaping (Result<UIImage, Error>) -> Void) {
    let key = url.absoluteString
    if let cachedImage = CacheManager.imageObject(forKey: key) {
      responseHandler(.success(cachedImage))
    } else {
      let downloadTask = self.session.dataTask(with: url) { (data, response, error) in
        guard error == nil else {
          responseHandler(.failure(NetworkError.invalidReponse(message: error!.localizedDescription)))
          return
        }
        guard let data = data,
              let image = UIImage(data: data) else {
          return
        }
        CacheManager.setObject(response: image, forKey: key)
        responseHandler(.success(image))
      }
      downloadTask.resume()
    }
  }
}
