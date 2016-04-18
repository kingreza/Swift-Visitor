//
//  car.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

struct Car {
  let make: String
  let model: String
  let mileage: Int

  init(make: String, model: String, mileage: Int) {
    self.make = make
    self.model = model
    self.mileage = mileage
  }
}
