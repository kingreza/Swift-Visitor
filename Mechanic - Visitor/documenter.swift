//
//  document_visitor.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

protocol Documenter {
  func process(documentable: Quote)
  func process(documentable: Appointment)
}
