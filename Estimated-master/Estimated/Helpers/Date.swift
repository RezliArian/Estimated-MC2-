//
//  Date.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 20/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import Foundation

extension Date {
  func convertToFormattedString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
    let date = dateFormatter.string(from: self)
    return date
  }
}


extension TimeInterval {
  func formatToString(with style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = style
    guard let formattedString = formatter.string(from: self) else { return "" }
    return formattedString
  }
}
