//
//  CheckIn.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/28/21.
//

import Foundation

class CheckIn: NSObject, NSCoding {
 
    // MARK: - Constants
    
    private static let dayCacheKey = "CheckInDayCacheKey"
    private static let frontLeftCacheKey = "CheckInFrontLeftCacheKey"
    private static let frontRightCacheKey = "CheckInFrontRightCacheKey"
    private static let sideLeftCacheKey = "CheckInSideLeftCacheKey"
    private static let sideRightCacheKey = "CheckInSideRightCacheKey"
    private static let roundhouseLeftCacheKey = "CheckInRoundhouseLeftCacheKey"
    private static let roundhouseRightCacheKey = "CheckInRoundhouseRightCacheKey"
    
    // MARK: - Properties
    
    var day: Int?
    var frontLeft: Double?
    var frontRight: Double?
    var sideLeft: Double?
    var sideRight: Double?
    var roundhouseLeft: Double?
    var roundhouseRight: Double?
    
    // MARK: - Init
    
    override init() {
        
    }
    
    // MARK: - NSCoding
    
    required init?(coder decoder: NSCoder) {
        if let cachedDay = decoder.decodeObject(forKey: CheckIn.dayCacheKey) as? NSNumber {
            day = cachedDay.intValue
        }
        if let cachedFrontLeft = decoder.decodeObject(forKey: CheckIn.frontLeftCacheKey) as? NSNumber {
            frontLeft = cachedFrontLeft.doubleValue
        }
        if let cachedFrontRight = decoder.decodeObject(forKey: CheckIn.frontRightCacheKey) as? NSNumber {
            frontRight = cachedFrontRight.doubleValue
        }
        if let cachedSideLeft = decoder.decodeObject(forKey: CheckIn.sideLeftCacheKey) as? NSNumber {
            sideLeft = cachedSideLeft.doubleValue
        }
        if let cachedSideRight = decoder.decodeObject(forKey: CheckIn.sideRightCacheKey) as? NSNumber {
            sideRight = cachedSideRight.doubleValue
        }
        if let cachedRoundhouseLeft = decoder.decodeObject(forKey: CheckIn.roundhouseLeftCacheKey) as? NSNumber {
            roundhouseLeft = cachedRoundhouseLeft.doubleValue
        }
        if let cachedRoundhouseRight = decoder.decodeObject(forKey: CheckIn.roundhouseRightCacheKey) as? NSNumber {
            roundhouseRight = cachedRoundhouseRight.doubleValue
        }
    }
    
    func encode(with coder: NSCoder) {
        if let day = day {
            coder.encode(NSNumber(value: day), forKey: CheckIn.dayCacheKey)
        }
        if let frontLeft = frontLeft {
            coder.encode(NSNumber(value: frontLeft), forKey: CheckIn.frontLeftCacheKey)
        } else {
            coder.encode(nil, forKey: CheckIn.frontLeftCacheKey)
        }
        if let frontRight = frontRight {
            coder.encode(NSNumber(value: frontRight), forKey: CheckIn.frontRightCacheKey)
        } else {
            coder.encode(nil, forKey: CheckIn.frontRightCacheKey)
        }
        if let sideLeft = sideLeft {
            coder.encode(NSNumber(value: sideLeft), forKey: CheckIn.sideLeftCacheKey)
        } else {
            coder.encode(nil, forKey: CheckIn.sideLeftCacheKey)
        }
        if let sideRight = sideRight {
            coder.encode(NSNumber(value: sideRight), forKey: CheckIn.sideRightCacheKey)
        } else {
            coder.encode(nil, forKey: CheckIn.sideRightCacheKey)
        }
        if let roundhouseLeft = roundhouseLeft {
            coder.encode(NSNumber(value: roundhouseLeft), forKey: CheckIn.roundhouseLeftCacheKey)
        } else {
            coder.encode(nil, forKey: CheckIn.roundhouseLeftCacheKey)
        }
        if let roundhouseRight = roundhouseRight {
            coder.encode(NSNumber(value: roundhouseRight), forKey: CheckIn.roundhouseRightCacheKey)
        } else {
            coder.encode(nil, forKey: CheckIn.roundhouseRightCacheKey)
        }
    }
    
}
