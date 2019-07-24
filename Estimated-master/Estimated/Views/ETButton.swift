
//
//  ETButton.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class ETButton: UIButton {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.setupView()
  }
  
  func setupView() {
    self.setTitleColor(.white, for: .normal)
    self.layer.cornerRadius = 5
    self.backgroundColor = Colors.purple
  }
  
}
