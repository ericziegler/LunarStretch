//
//  ScheduleDay.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

class ScheduleDay: NSObject, Codable, NSCoding {
    
    // MARK: - Constants
    
    private static let dayCacheKey = "ScheduleDayDayCacheKey"
    private static let stretchesCacheKey = "ScheduleDayStretchesCacheKey"
    
    // MARK: - Coding
    
    enum CodingKeys: String, CodingKey {
        case day
        case stretches
    }
 
    // MARK: - Properties
    
    var day: Int?
    var stretches: [ScheduleStretch]?
    var isCompleted: Bool {
        if let stretches = stretches {
            for curStretch in stretches {
                if curStretch.isCompleted == false {
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: - Init
    
    override init() {
        
    }
    
    // MARK: - NSCoding
    
    required init?(coder decoder: NSCoder) {
        if let cachedDay = decoder.decodeObject(forKey: ScheduleDay.dayCacheKey) as? NSNumber {
            day = cachedDay.intValue
        }
        if let stretchData = decoder.decodeObject(forKey: ScheduleDay.stretchesCacheKey) as? Data, let cachedStretches = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(stretchData) as? [ScheduleStretch] {
            stretches = cachedStretches
        }
    }
    
    func encode(with coder: NSCoder) {
        if let day = day {
            coder.encode(NSNumber(value: day), forKey: ScheduleDay.dayCacheKey)
        }
        if let stretches = stretches {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: stretches, requiringSecureCoding: false)
            coder.encode(data, forKey: ScheduleDay.stretchesCacheKey)
        }
    }
    
}
