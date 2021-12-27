//
//  AlarmManager.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation
import AudioToolbox

class AlarmManager {
 
    // MARK: - Properties
    
    let alarmSoundId: SystemSoundID? = {
        guard let soundURL = URL(string: "/System/Library/Audio/UISounds/SIMToolkitPositiveACK.caf") else {
            return nil
        }
        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundId)
        return soundId
    }()
    let tickSoundId: SystemSoundID? = {
        guard let soundURL = URL(string: "/System/Library/Audio/UISounds/Tock.caf") else {
            return nil
        }
        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundId)
        return soundId
    }()
    let beginSoundId: SystemSoundID? = {
        guard let soundURL = URL(string: "/System/Library/Audio/UISounds/RingerChanged.caf") else {
            return nil
        }
        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundId)
        return soundId
    }()
    let timerInterval: TimeInterval = 2
    var alarmTimer: Timer?
    
    // MARK: - Init
    
    static let shared = AlarmManager()
    
    // MARK: - Alarm
    
    func playAlarm() {
        endAlarm()
        triggerAlarm()
        alarmTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(triggerAlarm), userInfo: nil, repeats: true)
    }

    func endAlarm() {
        alarmTimer?.invalidate()
    }
    
    func playTick() {
        if let soundId = tickSoundId {
            AudioServicesPlaySystemSound(soundId)
        }
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    func playBeginTimer() {
        if let soundId = beginSoundId {
            AudioServicesPlaySystemSound(soundId)
        }
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

    @objc private func triggerAlarm() {
        if let soundId = alarmSoundId {
            AudioServicesPlaySystemSound(soundId)
        }
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
}
