//
//  EstimationDetailDataCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 21/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class EstimationDetailDataCell: UITableViewCell {

  
  @IBOutlet weak var estimatedDetailLabel: UILabel! {
    didSet {
      self.estimatedDetailLabel.textColor = Colors.lightPurple
    }
  }
  @IBOutlet weak var spentTimeDetailLabel: UILabel! {
    didSet {
      self.estimatedDetailLabel.textColor = Colors.purple
    }
  }
  
  
}
