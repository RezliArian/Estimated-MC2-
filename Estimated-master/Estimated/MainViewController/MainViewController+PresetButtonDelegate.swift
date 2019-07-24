//
//  MainViewController+PresetButtonDelegate.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

extension MainViewController: PresetButtonDelegate {
  func addInterval(with interval: TimeInterval) {
    duration = 0
    duration += Int(interval)
    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.none)
  }
}
