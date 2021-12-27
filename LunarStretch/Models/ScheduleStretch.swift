//
//  ScheduleStretch.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

struct ScheduleStretch: Codable {
    
    // MARK: - Coding
    
    enum CodingKeys: String, CodingKey {
        case id
        case duration
    }
 
    // MARK: - Properties
    
    var id: String?
    var duration: String?
    
}
