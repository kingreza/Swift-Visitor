//
//  email.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

struct Email {
  let from: String
  let to: String
  let subject: String
  var body: String

  init(from: String = "hi@yourmechanic.com", to: String, subject: String = "", body: String = "" ) {
    self.from = from
    self.to = to
    self.subject = subject
    self.body = body
  }

  func process() {
    print("From: \(self.from)")
    print("To: \(self.to)")
    print("Subject: \(self.subject)")
    print("Body: \(body)")
  }
}
