//
//  PresetButtonCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

protocol PresetButtonDelegate: class {
  func addInterval(with interval: TimeInterval)
}

class PresetButtonCell: UITableViewCell {
  
  var dateComponents = DateComponents()
  
  weak var presetButtonDelegate: PresetButtonDelegate!
  
  var currentInterval: TimeInterval?
  
  @IBAction func fiveMinuteButtonTapped(_ sender: ETButton) {
    let nextFiveMinuteInterval = TimeInterval(15.0 * 60)
    self.presetButtonDelegate.addInterval(with: nextFiveMinuteInterval)
  }
  
  @IBAction func fifteenMinuteButtonTapped(_ sender: ETButton) {
    let nextFifteenMinute = TimeInterval(30.0 * 60)
    self.presetButtonDelegate.addInterval(with: nextFifteenMinute)
  }
  
  @IBAction func thirtyMinuteButtonTapped(_ sender: ETButton) {
    let nextThirtyMinute = TimeInterval(60.0 * 60)
    self.presetButtonDelegate.addInterval(with: nextThirtyMinute)
  }
}

