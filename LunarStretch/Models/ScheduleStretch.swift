//
//  ScheduleStretch.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

class ScheduleStretch: NSObject, Codable, NSCoding {
    
    // MARK: - Constants
    
    private static let idCacheKey = "ScheduleStretchIdCacheKey"
    private static let durationCacheKey = "ScheduleStretchDurationCacheKey"
    private static let isCompletedCacheKey = "ScheduleStretchIsCompletedCacheKey"
    
    // MARK: - Coding
    
    enum CodingKeys: String, CodingKey {
        case id
        case duration
    }
 
    // MARK: - Properties
    
    var id: String?
    var duration: String?
    var isCompleted: Bool = false
    var stretchInfo: StretchInfo?
    
    // MARK: - Init
    
    override init() {
        
    }
    
    // MARK: - NSCoding
    
    required init?(coder decoder: NSCoder) {
        if let cachedId = decoder.decodeObject(forKey: ScheduleStretch.idCacheKey) as? String {
            id = cachedId
        }
        if let cachedDuration = decoder.decodeObject(forKey: ScheduleStretch.durationCacheKey) as? String {
            duration = cachedDuration
        }
        if let cachedIsCompleted = decoder.decodeObject(forKey: ScheduleStretch.isCompletedCacheKey) as? NSNumber {
            isCompleted = cachedIsCompleted.boolValue
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: ScheduleStretch.idCacheKey)
        coder.encode(duration, forKey: ScheduleStretch.durationCacheKey)
        coder.encode(NSNumber(value: isCompleted), forKey: ScheduleStretch.isCompletedCacheKey)
    }
    
}
