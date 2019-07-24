//
//  NotificationReminderSettingsViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 16/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

protocol NotificationReminderSettingsDelegate: class {
  func didSelectInterval(with interval: Int)
}

class NotificationReminderSettingsViewController: UITableViewController {
  
  weak var notificationIntervalDelegate: NotificationReminderSettingsDelegate!
  
  let intervalOptions = [1, 5, 10, 15, 30]
  
  var interval = 0
  
  var selectedCellRow: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Notification interval"
    navigationController?.navigationBar.prefersLargeTitles = false
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "IntervalCell")
    
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 5
    }
    return 5
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "IntervalCell", for: indexPath) as UITableViewCell
      let option = intervalOptions[indexPath.row]
      cell.textLabel?.text = "\(option) Minutes"
      if indexPath.row == intervalOptions.firstIndex(of: interval) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        cell.accessoryType = .checkmark
      }
      cell.selectionStyle = .none
      return cell
      
    }
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return "Set notification interval to remind you after your timer is passed"
  }
  
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark
    let selectedInterval = intervalOptions[indexPath.row]
    self.notificationIntervalDelegate.didSelectInterval(with: selectedInterval)
    print("selected interval", selectedInterval)
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .none
    
  }
}
