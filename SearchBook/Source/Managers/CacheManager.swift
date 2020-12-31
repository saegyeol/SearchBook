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
  static var searchResponseCache: NSCache = NSCache<NSString, ResponseCacheData<SearchResult>>()
  static var detailBookResponseCache: NSCache = NSCache<NSString, ResponseCacheData<DetailBook>>()
}
