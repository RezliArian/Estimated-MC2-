//
//  ViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import OnboardKit
import UserNotifications

class MainViewController: UIViewController {
  
  var duration: Int = 15 * 60
  var intervalSetting = 5
  var taskName = ""
  var taskNameTextFieldCharactersCount = 0
  
  var cellHeights: [IndexPath: CGFloat] = [:]
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Set Timer"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationController?.navigationBar.tintColor = Colors.purple
    tabBarController?.tabBar.tintColor = Colors.purple
    
    setupCell()
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //    toggle this to show
    //    UserDefaults.standard.set(false, forKey: "onboardingScreenShown")
    
    
    //    let indexPath = IndexPath(row: 0, section: SetTimerSection.DurationPicker.rawValue)
    //    let durationCell = tableView.cellForRow(at: indexPath) as! DurationPickerCell
    //    durationCell.durationPicker.date = defaultDate!
    
    if !UserDefaults.standard.bool(forKey: "onboardingScreenShown") {
      self.showOnboardingPage()
      UserDefaults.standard.set(true, forKey: "onboardingScreenShown")
    }
  }
  
  
  @objc func keyboardWillShow(_ notification:Notification) {

    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }
  }

  @objc func keyboardWillHide(_ notification:Notification) {

    if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
  }
  
  //MARK:- Prepare Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    switch segue.identifier ?? "" {
    case "SetNotificatonReminderSegue":
      if let destinationController = segue.destination as? NotificationReminderSettingsViewController {
        destinationController.notificationIntervalDelegate = self
        destinationController.interval = intervalSetting
      }
    case "StartTimerSegue":
      
      let currentEstimation = Estimation(taskName: taskName, taskDate: Date(), estimatedTime: duration, spentTime: nil, isCancelled: false, cancellationReason: nil)
      
      if let destinationController = segue.destination as? TimerViewController {
        destinationController.currentEstimation = currentEstimation
        print(currentEstimation)
      }
    default:
      break
      
    }
  }
  
  
  // MARK: - Onboarding page
  lazy var onboardingPages: [OnboardPage] = {
    let pageOne = OnboardPage(title: "Welcome!",
                              imageName: "ikon",
                              description: "Estimated is a timer to help you improve your estimation",
                              advanceButtonTitle: "")
    
    let pageTwo = OnboardPage(title: "Setup timer",
                              imageName: "handslider",
                              description: "Set your estimation of how long it would take for you to do your task.",
                              advanceButtonTitle: "")
    
    let pageThree = OnboardPage(title: "Finish timer",
                                imageName: "clock-alt",
                                description: "Just tap the Finish button when you're done with your task. Remember, your task is independent from your timer.\n\nPlease turn on notification so you can get reminded when you're past the estimated time.",
                                advanceButtonTitle: "",
                                actionButtonTitle: "Enable Notifications",
                                action: { [weak self] completion in
                                  // get a reference to the app delegate
                                  let localNotifManager = LocalNotificationManager()
                                  localNotifManager.requestAuthorization()
    })
    
    let pageFour = OnboardPage(title: "Check your statistics",
                               imageName: "onboard-chart",
                               description: "You can check your performance and history in the statistics tab.",
                               advanceButtonTitle: "")
    
    let pageFive = OnboardPage(title: "You're all set!",
                               imageName: "ikon",
                               description: "Please turn on notifications so the app can remind you when you went past the estimated time.",
                               advanceButtonTitle: "Done")
    
    
    return [pageOne, pageTwo, pageThree, pageFour, pageFive]
  }()
  
  fileprivate func showOnboardingPage() {
    let appearance = OnboardViewController.AppearanceConfiguration(tintColor: Colors.purple, titleColor: Colors.purple)
    
    let onboardingViewController = OnboardViewController(pageItems: onboardingPages, appearanceConfiguration: appearance)
    onboardingViewController.modalPresentationStyle = .formSheet
    onboardingViewController.presentFrom(self, animated: true)
  }
  
}

//extension UITableView {
//  func reloadWithScroll() {
//    let offset = contentOffset
//    reloadData()
//    layoutIfNeeded()
//    setContentOffset(offset, animated: true)
//  }
//}
