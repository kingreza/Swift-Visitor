//
//  date_extensions.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

extension NSDateFormatter {
  convenience init(dateFormat: String) {
    self.init()
    self.dateFormat = dateFormat
  }
}

extension NSDate {
  struct Date {
    static let formatterShortDateAndTime = NSDateFormatter(dateFormat: "dd/M/yyyy, H:mm")
  }
  var shortDateAndTime: String {
    return Date.formatterShortDateAndTime.stringFromDate(self)
  }

  static func generateDateFromArray(input: [Int]) -> NSDate? {
    guard input.count == 6 else {
      return nil
    }
    let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
    let components = NSDateComponents()
    components.year = input[0]
    components.month = input[1]
    components.day = input[2]
    components.hour = input[3]
    components.minute = input[4]
    components.second = input[5]

    return calendar?.dateFromComponents(components)
  }

}
