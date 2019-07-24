//
//  EstimationPerformanceCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 20/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import Charts

class EstimationPerformanceCell: UITableViewCell, ChartViewDelegate {
  
  var accuracyData: [Double] = []
  
  @IBOutlet weak var lineChartView: LineChartView!
  
  override func awakeFromNib() {
    setChart()
  }
  
  func setChart() {
    var lineChartDataEntry = [ChartDataEntry]()
    for i in 0..<accuracyData.count {
      let value = ChartDataEntry(x: Double(i), y: accuracyData[i])
      lineChartDataEntry.append(value)
    }
    
    let line1 = LineChartDataSet(entries: lineChartDataEntry, label: "Accuracy")
    line1.lineWidth = 2
    line1.colors = [Colors.purple]
    line1.circleRadius = 4
    line1.circleColors = [Colors.purple]
  
    
    let data = LineChartData()
    data.addDataSet(line1)
    
    lineChartView.data = data
    lineChartView.leftAxis.axisMaximum = 100
    lineChartView.leftAxis.axisMinimum = 0
    lineChartView.rightAxis.axisMaximum = 100
    lineChartView.rightAxis.axisMinimum = 0
    
    lineChartView.xAxis.labelPosition = .bottom
    lineChartView.xAxis.drawGridLinesEnabled = false
    
    // make sure chart isn't scaled
    lineChartView.scaleXEnabled = false
    lineChartView.scaleYEnabled = false
    
    lineChartView.rightAxis.drawLabelsEnabled = false
    
    
    lineChartView.chartDescription?.text = "Your accuracy performance"
  }
  
}
