//
//  appointment.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class Appointment: Documentable {

  var customer: Customer
  var mechanic: Mechanic
  var price: Double
  var date: NSDate

  init(customer: Customer, mechanic: Mechanic, price: Double, date: NSDate) {
    self.customer = customer
    self.mechanic = mechanic
    self.price = price
    self.date = date
  }

  func accept (documenter: Documenter) {
    documenter.process(self)
  }
}
