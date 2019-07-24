//
//  MainViewController+StartTimerDelegate.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

extension MainViewController: StartTimerDelegate {
  func startTimerButtonDidTap() {
    self.performSegue(withIdentifier: "StartTimerSegue", sender: self)
  }
}
