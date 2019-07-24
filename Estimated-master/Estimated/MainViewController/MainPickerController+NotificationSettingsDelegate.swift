//
//  MainPickerController+NotificationSettingsDelegate.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit


extension MainViewController: NotificationReminderSettingsDelegate {
  func didSelectInterval(with interval: Int) {
    self.intervalSetting = interval
    print("interval settings", self.intervalSetting)
    let indexPath = IndexPath(row: 0, section: 1)
    let cell = tableView.cellForRow(at: indexPath)
    cell?.detailTextLabel?.text = "\(intervalSetting) Minutes"
  }
}
