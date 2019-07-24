//
//  LocalNotificationManager.swift
//  Estimated
//
//  Created by Eibiel Sardjanto on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//
//  https://learnappmaking.com/local-notifications-scheduling-swift/#the-local-notification-manager-class
//  https://www.simplifiedios.net/ios-local-notification-tutorial/#iOS_Local_Notification_When_App_is_in_Foreground

import Foundation
import UserNotifications
import UIKit

class LocalNotificationManager: UIViewController, UNUserNotificationCenterDelegate {
    var notifications = [myNotif]()
  
    struct myNotif {
        var id:String
        var title:String
        var subtitle:String
        var estimation:TimeInterval
    }
  
    func listScheduledNotifications()
    {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
          
            for notification in notifications {
                print(notification)
            }
        }
      
    }
  
    func requestAuthorization()
    {
        UNUserNotificationCenter.current() // 1
          .requestAuthorization(options: [.sound, .badge]) { // 2
                granted, error in
              if granted == true && error == nil {
                self.scheduleNotifications()
              }
        }
    }
  
    func schedule()
    {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
          
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break // Do nothing
            }
        }
    }
  
    private func scheduleNotifications()
    {
        for notification in notifications
        {
            let content      = UNMutableNotificationContent()
            content.title    = notification.title
            content.sound    = .default
            content.subtitle = notification.subtitle
          
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(notification.estimation), repeats: false)
          
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
          
            UNUserNotificationCenter.current().delegate = self
          
            UNUserNotificationCenter.current().add(request) { error in
              
                guard error == nil else { return }
              
                print("Notification scheduled! --- ID = \(notification.id), \(notification.estimation)")
            }
        }
    }

  
}
