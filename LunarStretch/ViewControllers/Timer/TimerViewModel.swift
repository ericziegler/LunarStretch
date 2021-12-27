//
//  TimerViewModel.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

class TimerViewModel {
    
    // MARK: - Properties
    
    typealias TimeUpdated = (_ time: Double, _ formattedTime: String) -> Void
    typealias TimerToggled = (_ paused: Bool) -> Void
    
    let timeUpdated: TimeUpdated
    let prepTimeUpdated: TimeUpdated
    let timerToggled: TimerToggled
    
    private let prepTime: Double
    private let startTime: Double
    private let step: Double
    private var timer: Timer?
    // the time when counting was started
    private(set) var from: Date?
    // the time when counting was stopped
    private(set) var to: Date?
    // the time when user pause timer
    private var timeIntervalTimelapsFrom: TimeInterval?
    // the total time before user paused timer
    private var timerSavedTime: TimeInterval = 0
    
    // MARK: - Init
    
    init(prepTime: Double = 1.0, startTime: Double = 1.0, step: Double = 1.0, prepTimeUpdated: @escaping TimeUpdated, timeUpdated: @escaping TimeUpdated, timerToggled: @escaping TimerToggled) {
        self.prepTime = prepTime
        self.startTime = startTime
        self.step = step
        self.prepTimeUpdated = prepTimeUpdated
        self.timeUpdated = timeUpdated
        self.timerToggled = timerToggled
    }
    
    deinit {
        deinitTimer()
    }
    
    private func initTimer() {
        let action: (Timer)->Void = { [weak self] timer in
            guard let strongSelf = self else {
                return
            }
            let to = Date().timeIntervalSince1970
            let timeIntervalFrom = strongSelf.timeIntervalTimelapsFrom ?? to
            let time = strongSelf.timerSavedTime + (to - timeIntervalFrom)
            if time > strongSelf.prepTime {
                var roundedTime = round(strongSelf.prepTime + strongSelf.startTime - time)
                if roundedTime <= 0 {
                    roundedTime = 0
                }
                strongSelf.timeUpdated(roundedTime, strongSelf.timeString(from: roundedTime))
            } else {
                var roundedTime = round(strongSelf.prepTime - time)
                if roundedTime <= 0 {
                    roundedTime = 0
                }
                strongSelf.prepTimeUpdated(roundedTime, strongSelf.timeString(from: roundedTime))
            }
        }
        if from == nil {
            from = Date()
        }
        if timeIntervalTimelapsFrom == nil {
            timeIntervalTimelapsFrom = Date().timeIntervalSince1970
        }
        timer = Timer.scheduledTimer(withTimeInterval: step, repeats: true, block: action)
    }
    
    private func deinitTimer() {
        //Saving last timelaps
        if let timeIntervalTimelapsFrom = timeIntervalTimelapsFrom {
            let to = Date().timeIntervalSince1970
            timerSavedTime += to - timeIntervalTimelapsFrom
        }
        //Invalidating
        timer?.invalidate()
        timer = nil
        timeIntervalTimelapsFrom = nil
    }
    
    // MARK: - Play / Pause
    
    func toggleTimer() {
        var isPaused = false
        if timer == nil {
            initTimer()
        } else {
            deinitTimer()
            isPaused = true
        }
        timerToggled(isPaused)
    }
    
    func cancelTimer() {
        deinitTimer()
        from = nil
        to = nil
        timerSavedTime = 0
    }
    
    // MARK: - Formatting
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
        return String(format: "%.2d:%.2d", minutes, seconds)
    }
}

