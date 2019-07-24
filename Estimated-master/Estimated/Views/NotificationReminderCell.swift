//
//  NotificationReminderCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit



class NotificationReminderCell: UITableViewCell {
  
  
  var interval: Int = 5 {
    didSet {
      detailLabel.text = "\(interval) minutes"
    }
  }
  
  @IBOutlet weak var titleLabel: UILabel! {
    didSet {
      titleLabel.text = "Remind me every"
    }
  }
  @IBOutlet weak var detailLabel: UILabel!
  
}

