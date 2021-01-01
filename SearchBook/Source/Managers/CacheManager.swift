//
//  ImageCacheManager.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import UIKit

final class CacheManager {
  //only memory cache
  static var imageCache: NSCache = NSCache<NSString, UIImage>()
  static var responseCache: NSCache = NSCache<NSString, NSData>()
  
  static func setObject(response data: Data, forKey: String) {
    let data = NSData(data: data)
    let key = NSString(string: forKey)
    self.responseCache.setObject(data, forKey: key)
  }
  
  static func responseObject(forKey: String) -> Data? {
    let key = NSString(string: forKey)
    guard let cachedData = self.responseCache.object(forKey: key) else {
      return nil
    }
    let data = Data(cachedData)
    return data
  }
  
  static func setObject(response image: UIImage, forKey: String) {
    let key = NSString(string: forKey)
    self.imageCache.setObject(image, forKey: key)
  }
  
  static func imageObject(forKey: String) -> UIImage? {
    let key = NSString(string: forKey)
    guard let cachedImage = self.imageCache.object(forKey: key) else {
      return nil
    }
    return cachedImage
  }
}
