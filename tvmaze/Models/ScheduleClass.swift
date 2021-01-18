//
//  ScheduleClass.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 17/01/21.
//

import Foundation

struct ScheduleClass: Codable {
    let time: String?
    let days: [Day]?
}
