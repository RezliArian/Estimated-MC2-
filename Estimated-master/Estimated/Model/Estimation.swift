//
//  Estimation.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import Foundation

struct Estimation {
  var taskName: String?
  var taskDate: Date?
  var estimatedTime: Int?
  var spentTime: Int?
  var isCancelled: Bool = false
  var cancellationReason: String?
  
  func estimationAccuracy() -> Double {
    
    var accuracy: Double?
    
    guard let estTime = self.estimatedTime,
          let spTime = self.spentTime else { return Double(0) }
    
    
    if estTime > self.spentTime! {
      accuracy = Double(spTime) / Double(estTime)
    } else {
      accuracy = Double(estTime) / Double(spTime)
    }
    
    return Double(accuracy!)
  }
}
