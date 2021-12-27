//
//  StretchInfo.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

struct StretchInfo: Codable {
    
    // MARK: - Coding
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case video
    }
 
    // MARK: - Properties
    
    var id: String?
    var name: String?
    var video: String?
    
}
