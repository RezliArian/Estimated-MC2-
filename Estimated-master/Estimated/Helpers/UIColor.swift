//
//  UIColor.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

extension UIColor {
  convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
  }
}


struct Colors {
  static let lightPurple = UIColor(r: 90, g: 97, b: 136, a: 1)
  static let purple = UIColor(r: 64, g: 68, b: 179, a: 1)
  static let darkRed = UIColor(r: 89, g: 24, b: 48, a: 1)
  static let lightRed = UIColor(r: 160, g: 24, b: 24, a: 1)
}
