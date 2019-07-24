//
//  ChartCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 19/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import Charts

class EstimationDetailChartCell: UITableViewCell {

  @IBOutlet weak var barChartView: BarChartView! {
    didSet {
      self.barChartView.drawGridBackgroundEnabled = false
      self.barChartView.xAxis.granularityEnabled = true
      self.barChartView.xAxis.granularity = 1
      let data = ["", "Estimated", "Spent Time"]
      self.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: data)
      self.barChartView.xAxis.labelPosition = .bottom
    }
  }
  
}
