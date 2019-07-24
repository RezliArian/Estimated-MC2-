//
//  TimerViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class TimerViewController: UIViewController, UNUserNotificationCenterDelegate {
  
  var currentEstimation: Estimation!
  
  weak var timer: Timer?
  
  var isTimerRunning = false
  
  lazy var timerStartedDate = Date()
  
  var seconds: Int = 0
  var progress: Double!
  
  var diffHrs = 0
  var diffMins = 0
  var diffSecs = 0
  
  // Adding container
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  // Core Data Entities Array
  public var activities = [Activity]()
  
  @IBOutlet weak var circularProgressBar: CircularProgressBar!
  
  @IBOutlet weak var cancelButton: UIButton! {
    didSet {
      cancelButton.backgroundColor = .clear
      cancelButton.setTitleColor(.red, for: .normal)
    }
  }
  @IBOutlet weak var doneButton: ETButton!
  
  @IBOutlet weak var taskNameLabel: UILabel!
  @IBOutlet weak var estimationLabel: UILabel! {
    didSet {
      if seconds > currentEstimation.estimatedTime! {
        self.estimationLabel.textColor = Colors.lightRed
      }
    }
  }
  
  @IBAction func cancelButtonDidTap(_ sender: ETButton) {
    let alertController = UIAlertController(title: "Cancel timer", message: "Are you sure to cancel running timer? Please provide cancellation reason below.", preferredStyle: .alert)
    alertController.addTextField { (textField: UITextField) in
      textField.placeholder = "Cancellation Reason"
    }
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      self.timer?.invalidate()
      self.isTimerRunning = false
      let cancellationReason = alertController.textFields![0] as UITextField
      if cancellationReason.text!.count > 1 {
        self.addCancelledActivity(cancellationReason: cancellationReason.text!)
      } else {
        self.addCancelledActivity(cancellationReason: "-")
      }
      self.dismiss(animated: true, completion: {
        self.dismiss(animated: true, completion: nil)
      })
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func doneButtonDidTap(_ sender: ETButton) {
    
    // show alert controller
    let alertController = UIAlertController(title: "Finish timer?", message: "Are you sure to finish the timer?", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Finish", style: .default) { (_) in
      self.timer?.invalidate()
      self.addActivity()
      self.dismiss(animated: true, completion: {
        self.performSegue(withIdentifier: "ShowEstimationHistorySegue", sender: self)
      })
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    startTimer()
    
//    guard let spent = currentEstimation.spentTime else { return }
    
    NotificationCenter.default.addObserver(self, selector: #selector(pauseWhenBackground(noti:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(noti:)), name: UIApplication.willEnterForegroundNotification, object: nil)
  }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    switch segue {
//    case "ShowEstimationHistorySegue":
//      break
//    default:
//      break
//    }
//  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    taskNameLabel.text = currentEstimation.taskName!
    estimationLabel.text = "Estimation: \(Double(currentEstimation.estimatedTime!).formatToString(with: .abbreviated))"
  
    updateProgressCircleBar()
  }
  
  func updateProgressCircleBar() {
    if self.progress != nil {
      DispatchQueue.main.async {
        self.circularProgressBar.setProgress(to: self.progress, withAnimation: false)
      }
    }
  }
  
  @objc func pauseWhenBackground(noti: Notification) {
    self.timer?.invalidate()
    let shared = UserDefaults.standard
    shared.set(Date(), forKey: "savedTime")
  }
  
  @objc func willEnterForeground(noti: Notification) {
    if let savedDate = UserDefaults.standard.object(forKey: "savedTime") as? Date {
      (diffHrs, diffMins, diffSecs) = TimerViewController.getTimeDifference(startDate: savedDate)
      self.refresh(hours: diffHrs, mins: diffMins, secs: diffSecs)
    }
  }
  
  static func getTimeDifference(startDate: Date) -> (Int, Int, Int) {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
    return(components.hour!, components.minute!, components.second!)
  }
  
  func refresh (hours: Int, mins: Int, secs: Int) {
    let hrs = hours * 3600
    let minutes = mins * 60
    let s = secs
    seconds += hrs + minutes + s + 1
    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
  }
  
  
  func startTimer() {
    if !isTimerRunning {
      runTimer()
      scheduleReminder()
      isTimerRunning = true
    } else {
    }
  }
  
  func runTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    circularProgressBar.labelSize = 24
    circularProgressBar.safePercent = 80
    circularProgressBar.lineWidth = 25
  }
  
  func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i : %02i : %02i", hours, minutes, seconds)
  }
  
  @objc func updateTimerLabel() {
    
    seconds += 1
    
    //    let hours = Int(seconds) / 3600
    //    let minutes = Int(seconds) / 60 % 60
    //
    //    let stringOfHours = String(format: "%02d", hours)
    //    let stringOfMinutes = String(format: "%02d", minutes)
    //    let stringOfSeconds = String(format: "%02d", seconds)
    //
    //    let timerText = "\(stringOfHours) : \(stringOfMinutes) : \(stringOfSeconds)"
    
    //    timerLabel.text = timeString(time: TimeInterval(seconds))
    
    circularProgressBar.setLabel = timeString(time: TimeInterval(seconds))
    
    progress = Double(seconds) / Double(currentEstimation.estimatedTime!)
    if progress! <= 1 {
      circularProgressBar.setProgress(to: progress!, withAnimation: false)
    }
  }
  
  //adding activity without cancel
  func addActivity() {
    let estimation = Activity(entity: Activity.entity(), insertInto: context)
    estimation.taskName = currentEstimation.taskName!
    estimation.estimatedTime = Int32(currentEstimation.estimatedTime!)
    estimation.spentTime = Int32(seconds)
    estimation.date = Date()
    estimation.isCancelled = false
    estimation.cancellationReason = "-"
    activities.append(estimation)
    appDelegate.saveContext()
    print("Successfully saved estimation!")
  }
  
  //adding activity with cancellation reason
  func addCancelledActivity(cancellationReason: String) {
    let estimation = Activity(entity: Activity.entity(), insertInto: context)
    estimation.taskName = currentEstimation.taskName!
    estimation.estimatedTime = Int32(currentEstimation.estimatedTime!)
    estimation.spentTime = Int32(seconds)
    estimation.date = Date()
    estimation.isCancelled = true
    estimation.cancellationReason = cancellationReason
    activities.append(estimation)
    appDelegate.saveContext()
    print("Successfully saved estimation with cancellation reason!")
  }
  
  
  func scheduleReminder(){
    let estimation: TimeInterval = TimeInterval(currentEstimation.estimatedTime!)
    let reminder = LocalNotificationManager()
    
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minute = calendar.component(.minute, from: date)
    
    reminder.notifications = [
      LocalNotificationManager.myNotif(id: "reminder", title: "You're past your estimation!", subtitle: "It is past \(hour):\(minute)", estimation: estimation)
    ]
    
    reminder.schedule()
    reminder.listScheduledNotifications()
  }
  
}
