//
//  UIImageView+Download.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import UIKit

extension UIImageView {
  func setImage(with url: URL) {
    let downloader = APIClient.shared
    
    downloader.downloadImage(with: url) { (response) in
      switch response {
      case .success(let image):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.image = image
        }
      case .failure(_):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.image = nil
        }
      }
    }
  }
}
