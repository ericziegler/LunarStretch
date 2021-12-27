//
//  TimePickerViewModel.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

class TimePickerViewModel {
 
    var times = [TimeInterval]()
    var timeCount: Int {
        return times.count
    }
    
    init() {
        setupDefaultTimes()
    }
    
    private func setupDefaultTimes() {
        times.removeAll()
        // TODO: EZ - Remove
        times.append(4)
        times.append(15)
        times.append(20)
        times.append(25)
        times.append(30)
        times.append(35)
        times.append(40)
    }
    
    func formattedTimeAt(index: Int) -> String {
        if index < 0 || index >= times.count {
            return ""
        }
        return "\(String(Int(times[index])))s"
    }
    
}
