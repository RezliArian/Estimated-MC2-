//
//  MainViewController+UITableViewDelegate.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 1:
      if indexPath.row == 0 {
        tableView.deselectRow(at: indexPath, animated: true)
      }
      self.performSegue(withIdentifier: "SetNotificatonReminderSegue", sender: indexPath.row)
    default:
      break
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let sectionNumber = indexPath.section
    
    if sectionNumber == SetTimerSection.DurationPicker.rawValue {
      if indexPath.row == 0 {
        return 250
      } else if indexPath.row == 1 {
        return 68
      }
    }
    return 44
  }
  
}
