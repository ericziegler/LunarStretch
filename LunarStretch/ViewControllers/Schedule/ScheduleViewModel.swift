//
//  ScheduleViewModel.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

class ScheduleViewModel {
    
    // MARK: - Properties
    
    static let checkInId = "88A19775-0997-4348-B4E8-FF9E38591C1D"
    private var stretchesLookup = [String : StretchInfo]()
    var days = [ScheduleDay]()
    var completedToggled: ((_ indexPath: IndexPath) -> Void)?
    var daysCompleted: Int {
        var count = 0
        for curDay in days {
            if curDay.isCompleted == true {
                count += 1
            }
        }
        return count
    }
    var dayProgress: String {
        if days.count == 0 {
            return ""
        }
        var percentage = Double(daysCompleted) / Double(days.count)
        percentage = percentage * Double(100)
        let percentageString = "\(Int(percentage))%"
        
        return "\(daysCompleted) / \(days.count) Days Completed (\(percentageString))"
    }
    var stretchProgress: String {
        var stretchCount = 0
        var completeCount = 0
        for curDay in days {
            if let stretches = curDay.stretches {
                for curStretch in stretches {
                    stretchCount += 1
                    if curStretch.isCompleted == true {
                        completeCount += 1
                    }
                }
            }
        }
        if stretchCount == 0 {
            return ""
        }
        var percentage = Double(completeCount) / Double(stretchCount)
        percentage = percentage * Double(100)
        let percentageString = "\(Int(percentage))%"
        
        return "\(completeCount) / \(stretchCount) Total Stretches (\(percentageString))"
    }
 
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
    
    // MARK: - Accessors
    
    func stretchAt(indexPath: IndexPath) -> ScheduleStretch? {
        let curDay = days[indexPath.section]
        if let stretches = curDay.stretches {
            return stretches[indexPath.row]
        }
        return nil
    }
    
    func toggleStretchCompletedAt(indexPath: IndexPath) {
        guard let curStretch = stretchAt(indexPath: indexPath)  else {
            return
        }
        curStretch.isCompleted = !curStretch.isCompleted
        saveSchedule()
        completedToggled?(indexPath)
    }
    
}
