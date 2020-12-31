//
//  NavigationController.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/29.
//

import UIKit

class NavigationController: UINavigationController {
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    self.navigationBar.prefersLargeTitles = true
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
