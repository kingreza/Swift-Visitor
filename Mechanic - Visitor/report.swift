//
//  report.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation


struct Report {

  let reportType: ReportType
  let title: String
  let content: String

  init(reportType: ReportType, title: String, content: String) {
    self.reportType = reportType
    self.title = title
    self.content = content
  }

  func process() {
    print("Report: \(self.title)")
    print("Content: \(self.content)")
    print("************************\n")
  }
}
