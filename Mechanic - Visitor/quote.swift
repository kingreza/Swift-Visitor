//
//  quote.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class Quote: Documentable {

  var customer: Customer
  var price: Double
  var car: Car

  init(customer: Customer, price: Double, car: Car) {
    self.customer = customer
    self.price = price
    self.car = car
  }

  func accept (documenter: Documenter) {
    documenter.process(self)
  }
}
