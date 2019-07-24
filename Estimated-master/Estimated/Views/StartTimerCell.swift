//
//  StartTimerCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

protocol StartTimerDelegate: class {
  func startTimerButtonDidTap()
}

class StartTimerCell: UITableViewCell {
  
  weak var startTimerDelegate: StartTimerDelegate!
  
  @IBOutlet weak var startTimerButton: ETButton!
  
  @IBAction func startTimerDidTap(_ sender: ETButton) {
    
    self.startTimerDelegate.startTimerButtonDidTap()
    
  }
  
}
