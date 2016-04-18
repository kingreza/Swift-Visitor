//
//  report_documenter.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class ReportDocumenter: Documenter {
  func process(documentable: Quote) {
    var content = "Quote for \(documentable.car.make) \(documentable.car.model) was generated \n"
    content += "Customer:\t \(documentable.customer.name) \n"
    content += "Address:\t \(documentable.customer.address) \n"
    content += "Quoted Price:\t \(documentable.price)"

    let report = Report(reportType: .Quote,
                        title: "Quote Generation Report for \(documentable.customer.name)",
                        content: content)

    report.process()
  }
  func process(documentable: Appointment) {
    var content = "Appointment for \(documentable.customer.name) was generated\n"
    content += "Customer:\t \(documentable.customer.name)\n"
    content += "Mechanic:\t \(documentable.mechanic.name)\n"
    content += "Time:\t \(documentable.date.shortDateAndTime)"
    content += "Price:\t \(documentable.price)"

    let report = Report(reportType: .Appointment,
                        title: "Appointment Generation Report for \(documentable.customer.name)",
                        content: content)

    report.process()

  }
}
