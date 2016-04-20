//
//  documentable.swift
//  Mechanic - Visitor
//
//  Created by Reza Shirazian on 2016-04-17.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

protocol Documentable {
  func accept (documenter: Documenter)
}
