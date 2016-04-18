//
//  customer.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

struct Customer {
  let name: String
  let email: String
  let zipcode: String
  let address: String

  init(name: String, email: String, zipcode: String, address: String) {
    self.name = name
    self.email = email
    self.zipcode = zipcode
    self.address = address
  }
}
