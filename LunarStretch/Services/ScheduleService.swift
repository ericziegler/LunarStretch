//
//  ScheduleService.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

// MARK: - TypeAliases

typealias ScheduleCompletionBlock = (_ result: [ScheduleDay]?, _ error: AppError?) -> ()

// MARK: - Services

class ScheudleService {
    
    // MARK: - Constants
    
    private let scheduleFileName = "schedule"
    private let scheduleFileExtension = "json"
    
    // MARK: - Loading
 
    func fetchSchedule(completion: ScheduleCompletionBlock?) {
        guard let data = Services.openFileNamed(name: scheduleFileName, fileExtension: scheduleFileExtension) else {
            completion?(nil, .fileOpen)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let schedule = try decoder.decode([ScheduleDay].self, from: data)
            completion?(schedule, nil)
        } catch {
            completion?(nil, .jsonParsing)
        }
    }
    
}
