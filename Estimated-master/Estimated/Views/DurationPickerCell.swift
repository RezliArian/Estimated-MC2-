//
//  DurationPickerViewCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

protocol DurationPickerDelegate: class {
  func durationPickerDidChange(with interval: TimeInterval)
}

class DurationPickerCell: UITableViewCell {
  
  var incrementInterval: TimeInterval?
  var durationPickerDelegate: DurationPickerDelegate!
  
  @IBOutlet weak var durationPicker: UIDatePicker!
  
  
  @IBAction func durationPickerDidChange(_ sender: UIDatePicker) {
    let duration = sender.countDownDuration
    durationPickerDelegate.durationPickerDidChange(with: duration)  
  }
  
}

extension DurationPickerCell: PresetButtonDelegate {
  func addInterval(with interval: TimeInterval) {
    durationPicker.countDownDuration += interval
  }
}
