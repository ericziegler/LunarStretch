//
//  ScheduleDay.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

struct ScheduleDay: Codable {
    
    // MARK: - Coding
    
    enum CodingKeys: String, CodingKey {
        case day
        case name
        case stretches
    }
 
    // MARK: - Properties
    
    var day: Int?
    var name: String?
    var stretches: [ScheduleStretch]?
    
}
