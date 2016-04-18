//
//  EmailDocumenter.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class EmailDocumenter: Documenter {
  func process(documentable: Quote) {
    var content = "Hello \(documentable.customer.name) \n"
    content += "We have a quote for your \(documentable.car.make) \(documentable.car.model) \n"
    content += "For the services you have requested in \(documentable.customer.address) \n"
    content += "We have generated a quote priced at \(documentable.price) \n"
    let email = Email(to: documentable.customer.email,
                      subject: "Here is a quote for your \(documentable.car.make)",
                      body: content)

    email.process()
  }

  func process(documentable: Appointment) {
    var content = "Hello \(documentable.customer.name) \n"
    content += "We have booked your appointment for \(documentable.date.shortDateAndTime) \n"
    content += "make sure you have not driven your car for an hour before the appointment \n"
    content += "\(documentable.mechanic.name) will be more than happy " +
               "to answer any questions you might have \n"
    content += "You card will be billed for \(documentable.price) " +
                "once the appointment is finished \n"

    let email = Email(to: documentable.customer.email,
                      subject: "Your appointment is set for \(documentable.date.shortDateAndTime)",
                      body: content)

     email.process()

  }
}
