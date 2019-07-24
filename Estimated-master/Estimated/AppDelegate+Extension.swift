//
//  AppDelegate+Extension.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 22/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import Foundation
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate {

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let timerViewController = TimerViewController()
    timerViewController.updateProgressCircleBar()
    return completionHandler()
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("call notif")
    return completionHandler(UNNotificationPresentationOptions.alert)
  }
}
