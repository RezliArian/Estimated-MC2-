//
//  EstimationDetailViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 19/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import Charts

class EstimationDetailViewController: UIViewController {
  
  var barChartData: BarChartData!
  var estimationData: Activity!
  
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Estimation Detail"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    setupCell()
  }
  
  func setupCell() {
    let detailChartCell = UINib(nibName: "EstimationDetailChartCell", bundle: nil)
    tableView.register(detailChartCell, forCellReuseIdentifier: "EstimationDetailChartCell")
    
    let estimationDetailDataCell = UINib(nibName: "EstimationDetailDataCell", bundle: nil)
    tableView.register(estimationDetailDataCell, forCellReuseIdentifier: "EstimationDetailDataCell")
    
    let estimationDetailTaskDataCell = UINib(nibName: "EstimationDetailTaskDataCell", bundle: nil)
    tableView.register(estimationDetailTaskDataCell, forCellReuseIdentifier: "EstimationDetailTaskDataCell")
    
  }
  
}

extension EstimationDetailViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return 250
    case 1:
      return 100
    default:
      break
    }
    return 100
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 2
    default:
      break
    }
    return 1
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationDetailChartCell", for: indexPath) as! EstimationDetailChartCell
      cell.barChartView.data = barChartData
      cell.selectionStyle = .none
      return cell
    case 1:
      if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationDetailTaskDataCell", for: indexPath) as! EstimationDetailTaskDataCell
        cell.taskNameLabel.text = "\(estimationData.taskName!)"
        cell.taskDateLabel.text = estimationData.date?.convertToFormattedString()
        cell.selectionStyle = .none
        return cell
      } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationDetailDataCell", for: indexPath) as! EstimationDetailDataCell
        cell.estimatedDetailLabel.text = "\(TimeInterval(estimationData.estimatedTime).formatToString(with: .short))"
        cell.spentTimeDetailLabel.text = "\(TimeInterval(estimationData.spentTime).formatToString(with: .short))"
        cell.selectionStyle = .none
        return cell
      }
    default:
      break
    }
    return UITableViewCell()
  }
}
