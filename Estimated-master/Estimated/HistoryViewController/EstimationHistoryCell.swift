//
//  EstimationHistoryCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class EstimationHistoryCell: UITableViewCell {
  
  @IBOutlet weak var taskNameLabel: UILabel!
  @IBOutlet weak var accuracyStatusLabel: UILabel!
  @IBOutlet weak var taskDateLabel: UILabel!
  @IBOutlet weak var percentAccuracyLabel: UILabel!
  @IBOutlet weak var percentAccuracyBackgroundView: UIView! {
    didSet {
      percentAccuracyBackgroundView.layer.cornerRadius = 8
    }
  }
  
}
