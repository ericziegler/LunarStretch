//
//  ScheduleViewModel.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

class ScheduleViewModel {
    
    // MARK: - Properties
    
    private var stretchesLookup = [String : StretchInfo]()
    var days = [ScheduleDay]()
 
    // MARK: - Init
    
    init() {
        loadStretchInfo()
        loadSchedule()
    }
    
    private func loadStretchInfo() {
        let services = StretchesService()
        guard let stretches = services.fetchStretches()  else {
            return
        }
        
        for curStretch in stretches {
            if let stretchId = curStretch.id {
                stretchesLookup[stretchId] = curStretch
            }
        }
    }
    
    private func loadSchedule() {
        let services = ScheduleService()
        guard let scheduleDays = services.fetchSchedule() else {
            return
        }
        
        // remove any previous stretches
        days.removeAll()
        for curDay in scheduleDays {
            // loop through each stretch in a single day and add its info
            if let stretches = curDay.stretches {
                for curStretch in stretches {
                    if let stretchId = curStretch.id, let stretchInfo = stretchesLookup[stretchId] {
                        curStretch.stretchInfo = stretchInfo
                    }
                }
            }
            // add the day to the collection
            days.append(curDay)
        }
    }
    
    func saveSchedule() {
        let services = ScheduleService()
        services.saveSchedule(schedule: days)
    }
    
}
