//
//  MainViewController+UITableViewDatasource.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit


extension MainViewController: UITableViewDataSource {
  
  enum SetTimerSection: Int {
    case DurationPicker = 0, NotificationReminder, TaskName, StartTimer
  }
  
  func setupCell() {
    let durationCell = UINib(nibName: "DurationPickerViewCell", bundle: nil)
    tableView.register(durationCell, forCellReuseIdentifier: "DurationPickerCell")
    
    let presetButtonCell = UINib(nibName: "PresetButtonCell", bundle: nil)
    tableView.register(presetButtonCell, forCellReuseIdentifier: "PresetButtonCell")
    
    let notificationReminderCell = UINib(nibName: "NotificationReminderCell", bundle: nil)
    tableView.register(notificationReminderCell, forCellReuseIdentifier: "NotificationReminderCell")
    
    let taskNameCell = UINib(nibName: "TaskNameCell", bundle: nil)
    tableView.register(taskNameCell, forCellReuseIdentifier: "TaskNameCell")
    
    let startTimerCell = UINib(nibName: "StartTimerCell", bundle: nil)
    tableView.register(startTimerCell, forCellReuseIdentifier: "StartTimerCell")
  }
  
  // MARK: - Deque cell function
  fileprivate func durationPickerCell(tableView: UITableView, indexPath: IndexPath) -> DurationPickerCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DurationPickerCell", for: indexPath) as! DurationPickerCell
    cell.durationPickerDelegate = self
    DispatchQueue.main.async {
      cell.durationPicker.countDownDuration = TimeInterval(self.duration)
    }
    return cell
  }
  
  fileprivate func presetButtonCell(tableView: UITableView, indexPath: IndexPath) -> PresetButtonCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PresetButtonCell", for: indexPath) as! PresetButtonCell
    cell.presetButtonDelegate = self
    cell.selectionStyle = .none
    return cell
  }
  
  fileprivate func notificationReminderCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationReminderCell", for: indexPath)
    cell.detailTextLabel?.text = "\(intervalSetting) Minutes"
    return cell
  }
  
  fileprivate func taskNameCell(tableView: UITableView, indexPath: IndexPath) -> TaskNameCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TaskNameCell", for: indexPath) as! TaskNameCell
    cell.selectionStyle = .none
    cell.taskNameCellDelegate = self
    return cell
  }
  
  fileprivate func startTimerCell(tableView: UITableView, indexPath: IndexPath) -> StartTimerCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StartTimerCell", for: indexPath) as! StartTimerCell
    cell.backgroundColor = .clear
    cell.selectionStyle = .none
    cell.startTimerDelegate = self
    if taskNameTextFieldCharactersCount == 0 {
      cell.startTimerButton.backgroundColor = UIColor.lightGray
      cell.startTimerButton.isEnabled = false
    } else {
      cell.startTimerButton.backgroundColor = Colors.purple
      cell.startTimerButton.isEnabled = true
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let sectionNumber = indexPath.section
    
    if sectionNumber == SetTimerSection.DurationPicker.rawValue {
      if indexPath.row == 0 {
        return durationPickerCell(tableView: tableView, indexPath: indexPath)
      } else if indexPath.row == 1 {
        return presetButtonCell(tableView: tableView, indexPath: indexPath)
      }
    } else if sectionNumber == SetTimerSection.NotificationReminder.rawValue {
      return notificationReminderCell(tableView: tableView, indexPath: indexPath)
    } else if sectionNumber == SetTimerSection.TaskName.rawValue {
      return taskNameCell(tableView: tableView, indexPath: indexPath)
    } else if sectionNumber == SetTimerSection.StartTimer.rawValue {
      return startTimerCell(tableView: tableView, indexPath: indexPath)
    } else {
      return UITableViewCell()
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case SetTimerSection.NotificationReminder.rawValue:
      return "Set notification reminder"
    case SetTimerSection.TaskName.rawValue:
      return "Enter task name"
    default:
      break
    }
    return ""
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 2
    case 1:
      return 1
    case 2:
      return 1
    case 3:
      return 1
    default:
      break
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cellHeights[indexPath] = cell.frame.size.height
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeights[indexPath] ?? 70.0
  }
  
  
}
