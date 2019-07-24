//
//  EstimationHistoryViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import Charts
import CoreData

class EstimationHistoryViewController: UIViewController {
  
  var estimations = [Activity]()
  var notCancelledEstimations = [Activity]()
  var notCancelledPredicate: NSPredicate?
  var barChartData: BarChartData!
  var estimationData: Activity!
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  @IBOutlet weak var tableView: UITableView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCell()
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Estimation History"
    
//    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete all record", style: .plain, target: self, action: #selector(deleteEstimations))
//    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Generate fake data", style: .plain, target: self, action: #selector(generateFakeData))
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchEstimations()
    tableView.reloadData()
  }
  
  // MARK: - Setup custom cell
  func setupCell() {
    let chartCell = UINib(nibName: "EstimationPerformanceCell", bundle: nil)
    tableView.register(chartCell, forCellReuseIdentifier: "EstimationPerformanceCell")
    
    let historyCell = UINib(nibName: "EstimationHistoryCell", bundle: nil)
    tableView.register(historyCell, forCellReuseIdentifier: "EstimationHistoryCell")
  }
  
  // MARK: - CoreData Function
  // Core data sort by latest entries
  func sortEstimationBasedOnDate() -> [NSSortDescriptor?] {
    return [NSSortDescriptor(key: "date", ascending: false)]
  }
  
  func fetchEstimations() {
    do {
      let activityFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
      let sortByDate = NSSortDescriptor(key: "date", ascending: false)
      
      // Sort by date
      activityFetchRequest.sortDescriptors = [sortByDate]
      
      // Fetch core data
      estimations = try context.fetch(activityFetchRequest) as! [Activity]
      
      // Add core data predicate to filter data that is cancelled
//      activityFetchRequest.predicate = notCancelledPredicate
//      notCancelledPredicate = NSPredicate(value: false)
      
      // Fetch estimation data that is not cancelled and store to array
//      notCancelledEstimations = try context.fetch(activityFetchRequest) as! [Activity]
      
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  func deleteAllActivity() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try context.execute(batchDeleteRequest)
    } catch let er as NSError {
      print("Something wrong", er)
    }
    
    tableView.reloadData()
  }
  
  @objc func deleteEstimations() {
    self.deleteAllActivity()
  }
  
  @objc func generateFakeData() {
    
    let est1 = Estimation(taskName: "Write proposal 1", taskDate: Date(), estimatedTime: 600, spentTime: 900, isCancelled: false, cancellationReason: "-")
    let est2 = Estimation(taskName: "Write proposal 2", taskDate: Date(), estimatedTime: 1200, spentTime: 2600, isCancelled: false, cancellationReason: "-")
    let est3 = Estimation(taskName: "Write proposal 3", taskDate: Date(), estimatedTime: 800, spentTime: 2400, isCancelled: false, cancellationReason: "-")
    let est4 = Estimation(taskName: "Write proposal 4", taskDate: Date(), estimatedTime: 2400, spentTime: 650, isCancelled: true, cancellationReason: "need to go (est4)")
    let est5 = Estimation(taskName: "Write proposal 5", taskDate: Date(), estimatedTime: 600, spentTime:2400, isCancelled: false, cancellationReason: "-")
    let est6 = Estimation(taskName: "Write proposal 6", taskDate: Date(), estimatedTime: 2400, spentTime: 1200, isCancelled: false, cancellationReason: "-")
    let est7 = Estimation(taskName: "Write proposal 7", taskDate: Date(), estimatedTime: 600, spentTime: 660, isCancelled: false, cancellationReason: "-")
    let est8 = Estimation(taskName: "Write proposal 8", taskDate: Date(), estimatedTime: 2400, spentTime: 120, isCancelled: true, cancellationReason: "need to go (est 8)")
    let est9 = Estimation(taskName: "Write proposal 9", taskDate: Date(), estimatedTime: 600, spentTime: 660, isCancelled: false, cancellationReason: "-")
    let est10 = Estimation(taskName: "Write proposal 10", taskDate: Date(), estimatedTime: 1200, spentTime: 900, isCancelled: false, cancellationReason: "-")
  
    let fakeEstimations = [
      est1,
      est2,
      est3,
      est4,
      est5,
      est6,
      est7,
      est8,
      est9,
      est10
    ]
    
    fakeEstimations.forEach { (estimation) in
      let estimationActivity = Activity(entity: Activity.entity(), insertInto: context)
      estimationActivity.taskName = estimation.taskName!
      estimationActivity.date = estimation.taskDate!
      estimationActivity.estimatedTime = Int32(estimation.estimatedTime!)
      estimationActivity.spentTime = Int32(estimation.spentTime!)
      estimationActivity.isCancelled = estimation.isCancelled
      estimationActivity.cancellationReason = estimation.cancellationReason!
      appDelegate.saveContext()
    }
    self.tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "ShowDetailViewControllerSegue":
      let vc = segue.destination as! EstimationDetailViewController
      vc.barChartData = self.barChartData
      vc.estimationData = self.estimationData
    default:
      break
    }
  }
  
  
}

extension EstimationHistoryViewController: UITableViewDataSource, UITableViewDelegate {
  
  enum HistorySection: Int {
    case ChartSection = 0, EstimationHistorySection
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 1:
      if estimations.count >= 1 {
        return "Your estimations history"
      } else {
        return "No estimations history found"
      }
    default:
      break
    }
    return ""
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case HistorySection.ChartSection.rawValue:
      return 1
    case HistorySection.EstimationHistorySection.rawValue:
      return estimations.count
    default:
      break
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = indexPath.section
    
    if section == HistorySection.ChartSection.rawValue {
      let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationPerformanceCell", for: indexPath) as! EstimationPerformanceCell
      notCancelledEstimations = estimations.filter { (activity) -> Bool in
        activity.isCancelled == false
      }
      
      var accuracy: [Double] = []
      
      notCancelledEstimations.forEach { (estimation) in
        let difference = estimation.estimatedTime - estimation.spentTime
        if difference < 0 {
          let accuracyLevel = Double(estimation.estimatedTime) / Double(estimation.spentTime) * 100
          accuracy.append(accuracyLevel)
        } else {
          let accuracyLevel = Double(estimation.spentTime) / Double(estimation.estimatedTime) * 100
          accuracy.append(accuracyLevel)
        }
      }
      
      cell.accuracyData = accuracy
      cell.setChart()
      
      return cell
    } else if section == HistorySection.EstimationHistorySection.rawValue {
      let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationHistoryCell", for: indexPath) as! EstimationHistoryCell
      
      if estimations.count >= 1 {
        let estimation = estimations[indexPath.row]
        cell.taskNameLabel.text = estimation.taskName!
        cell.taskDateLabel.text = estimation.date?.convertToFormattedString()
        if !estimation.isCancelled {
          let difference = estimation.estimatedTime - estimation.spentTime
          if difference < 0 {
            // spent time more than estimated time
            let percentAccuracy = Double(estimation.estimatedTime) / Double(estimation.spentTime) * 100
            cell.percentAccuracyBackgroundView.backgroundColor = Colors.lightRed
            cell.percentAccuracyLabel.text = "\(round(percentAccuracy))%"
            cell.accuracyStatusLabel.text = "You're late \(TimeInterval(difference * -1).formatToString(with: .short))"
            cell.accuracyStatusLabel.textColor = Colors.lightRed
          } else {
            // estimated time is more than spent time
            let percentAccuracy = Double(estimation.spentTime) / Double(estimation.estimatedTime) * 100
            cell.percentAccuracyBackgroundView.backgroundColor = Colors.purple
            cell.percentAccuracyLabel.text = "\(round(percentAccuracy))%"
            cell.accuracyStatusLabel.text = "You're early \(TimeInterval(difference).formatToString(with: .short))"
            cell.accuracyStatusLabel.textColor = Colors.purple
          }
        } else {
          cell.percentAccuracyBackgroundView.backgroundColor = .lightGray
          cell.percentAccuracyLabel.text = "-"
          cell.accuracyStatusLabel.text = "Timer cancelled"
          cell.accuracyStatusLabel.textColor = .lightGray
        }
      }
      return cell
    } else {
      return UITableViewCell()
    }
  }

  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let section = indexPath.section

    switch section {
    case HistorySection.ChartSection.rawValue:
      return 250
    case HistorySection.EstimationHistorySection.rawValue:
      return 100
    default:
      break
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 1:
      estimationData = estimations[indexPath.row]
      
      let spentTime = estimationData.spentTime
      let estimatedTime = estimationData.estimatedTime
      
      var barDataEntries: [BarChartDataEntry] = []
      barDataEntries.append(BarChartDataEntry(x: Double(1), y: Double(estimatedTime)))
      barDataEntries.append(BarChartDataEntry(x: Double(2), y: Double(spentTime)))
      
      let chartDataSet = BarChartDataSet(entries: barDataEntries, label: "Time")
      chartDataSet.colors = [Colors.lightPurple, Colors.purple]
      
      let chartData = BarChartData(dataSet: chartDataSet)
      
      self.barChartData = chartData
      
      performSegue(withIdentifier: "ShowDetailViewControllerSegue", sender: self)
    default:
      break
    }
  }
  
  
  
}
