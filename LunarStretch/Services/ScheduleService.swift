//
//  ScheduleService.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

// MARK: - Services

class ScheduleService {
    
    // MARK: - Constants
    
    private static let daysCacheKey = "ScheduleDaysCacheKey"
    private static let scheduleFileName = "schedule"
    private static let scheduleFileExtension = "json"
    
    // MARK: - Loading
 
    func fetchSchedule() -> [ScheduleDay]? {
        // attempt to load the cached schedule, if there is one. otherwise, load fresh from a file
        if let cachedSchedule = loadCachedSchedule() {
            return cachedSchedule
        }

        guard let data = Services.openFileNamed(name: ScheduleService.scheduleFileName, fileExtension: ScheduleService.scheduleFileExtension) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let schedule = try decoder.decode([ScheduleDay].self, from: data)
            return schedule
        } catch {
            print(error)
            return nil
        }
    }
    
    private func loadCachedSchedule() -> [ScheduleDay]? {
        if let scheduleData = UserDefaults.standard.object(forKey: ScheduleService.daysCacheKey) as? Data, let days = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(scheduleData) as? [ScheduleDay] {
            return days
        }
        return nil
    }
    
    func saveSchedule(schedule: [ScheduleDay]) {
        let scheduleData = try? NSKeyedArchiver.archivedData(withRootObject: schedule, requiringSecureCoding: false)
        UserDefaults.standard.set(scheduleData, forKey: ScheduleService.daysCacheKey)
        UserDefaults.standard.synchronize()
    }
    
}
