//
//  ImageCacheManager.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import UIKit

final class ImageCacheManager {
  static var cache: NSCache = NSCache<NSString, UIImage>()
}
