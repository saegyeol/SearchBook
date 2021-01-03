//
//  APIClient.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import UIKit

protocol APIClientAble {
  func request(with target: Routable, responseHandler: @escaping (Result<Data, NetworkError>) -> Void)
  func downloadImage(with url: URL, responseHandler: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class APIClient: APIClientAble {
  static let shared = APIClient(session: URLSession.shared)
  private let session: URLSession
  
  private init(session: URLSession) {
    self.session = session
  }
  
  public func request(with target: Routable, responseHandler: @escaping (Result<Data, NetworkError>) -> Void) {
    do {
      let request = try target.asURLRequest()
      let key = request.url!.absoluteString
      if let cacheData = CacheManager.responseObject(forKey: key) {
        responseHandler(.success(cacheData))
      } else {
        let dataTask = self.session.dataTask(with: request) { (data, response, error) in

          guard let httpResponse = response as? HTTPURLResponse else {
            let errorMessage = error!.localizedDescription
            let error = NetworkError(type: NetworkErrorCase.invalidResponse,
                                     message: errorMessage)
            responseHandler(.failure(error))
            return
          }
          
          guard error == nil else {
            let errorMessage = error!.localizedDescription
            let error = NetworkError(type: NetworkErrorCase.invalidResponse,
                                     message: errorMessage)
            responseHandler(.failure(error))
            return
          }
          guard let data = data else {
             return
          }
          
          if httpResponse.statusCode == 200 {
            CacheManager.setObject(response: data, forKey: key)
            responseHandler(.success(data))
          } else if httpResponse.statusCode == 404 {
            let error = NetworkError(type: NetworkErrorCase.responseDataIsEmpty,
                                     message: "Data is not found")
            responseHandler(.failure(error))
          } else if httpResponse.statusCode == 500 {
            let error = NetworkError(type: NetworkErrorCase.internalServerError,
                                     message: "Internal server error")
            responseHandler(.failure(error))
          } else {
            let error = NetworkError(type: NetworkErrorCase.unexpectedError,
                                     message: "Unexpected Error please, contact us")
            responseHandler(.failure(error))
          }
        }
        dataTask.resume()
      }
    } catch {
      responseHandler(.failure(error as! NetworkError))
    }
  }
  
  public func downloadImage(with url: URL, responseHandler: @escaping (Result<UIImage, NetworkError>) -> Void) {
    let key = url.absoluteString
    if let cachedImage = CacheManager.imageObject(forKey: key) {
      responseHandler(.success(cachedImage))
    } else {
      let downloadTask = self.session.dataTask(with: url) { (data, response, error) in
        let errorMessage = error.debugDescription
        guard let _ = response as? HTTPURLResponse else {
          let error = NetworkError(type: NetworkErrorCase.invalidResponse,
                                   message: errorMessage)
          responseHandler(.failure(error))
          return
        }
        
        guard error == nil else {
          let error = NetworkError(type: NetworkErrorCase.invalidResponse,
                                   message: errorMessage)
          responseHandler(.failure(error))
          return
        }
        guard let data = data,
              let image = UIImage(data: data) else {
          let error = NetworkError(type: NetworkErrorCase.invalidData,
                                    message: "Data is not image")
          responseHandler(.failure(error))
          return
        }
        CacheManager.setObject(response: image, forKey: key)
        responseHandler(.success(image))
      }
      downloadTask.resume()
    }
  }
}
