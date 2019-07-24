//
//  MainViewController+DurationPickerDelegate.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
extension MainViewController: DurationPickerDelegate {
  func durationPickerDidChange(with interval: TimeInterval) {
    duration = Int(interval)
//    let indexPath = IndexPath(row: 0, section: SetTimerSection.DurationPicker.rawValue)
//    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
}
