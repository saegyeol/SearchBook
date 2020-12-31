//
//  UIImageView+Download.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import UIKit

extension UIImageView {
  func setImage(with url: URL, downloader: APIServiceType) {
    let cacheKey = url.absoluteString
    
    if let image = ImageCacheManager.cache.object(forKey: NSString(string: cacheKey)) {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else {
          return
        }
        self.image = image
      }
    } else {
      downloader.imageLoad(with: url) { (response) in
        switch response {
        case .success(let data):
          if let image = UIImage(data: data) {
            ImageCacheManager.cache.setObject(image, forKey: NSString(string: cacheKey))
            self.image = image
          }
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}
