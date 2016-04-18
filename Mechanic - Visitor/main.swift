//
//  main.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation


var joe = Mechanic(name: "Joe Stevenson")
var mike = Mechanic (name: "Mike Dundee")

var reza = Customer(name: "Reza Shirazian", email: "reza@yourmechanic.com", zipcode: "94043", address: "N Rengstorff ave")

var lyanne = Customer(name: "Lyanne Borne", email: "jb_hhm@yahoo.com", zipcode: "37110", address: "E Main St McMinnvile TN")

var sam = Customer(name: "Sam Lee", email: "lee.sam.3oo@gmail.com", zipcode: "95060", address: "Pacific Ave, Santa Cruz")

var quote1 = Quote(customer: reza, price: 55.00, car: Car(make: "Ford", model: "Mustang", mileage: 9500))
var quote2 = Quote(customer: lyanne, price: 463.25, car: Car(make: "Chevrolet", model: "Silverado", mileage: 15200))
var quote3 = Quote(customer: sam, price: 1155.00, car: Car(make: "Honda", model: "Civic", mileage: 78000))

var appointment1 = Appointment(customer: reza, mechanic: joe, price: 455.88, date: NSDate.generateDateFromArray([2016, 5, 12, 14, 30, 00])!)

var appointment2 = Appointment(customer: sam, mechanic: mike, price: 554.00, date: NSDate.generateDateFromArray([2016, 5, 23, 20, 00, 00])!)

var quotes = [quote1, quote2, quote3]
var appointments = [appointment1, appointment2]

var emailDocumenter = EmailDocumenter()

var reportDocumenter = ReportDocumenter()

for quote in quotes {
  quote.accept(emailDocumenter)
  quote.accept(reportDocumenter)
}

for appointment in appointments {
  appointment.accept(emailDocumenter)
  appointment.accept(reportDocumenter)
}
