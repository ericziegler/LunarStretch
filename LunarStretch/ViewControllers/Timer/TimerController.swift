//
//  TimerController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit
import AudioToolbox

class TimerController: BaseViewController {
    
    // MARK: - Properties
    
    static let storyboardId = "TimerControllerId"
    
    @IBOutlet var playPauseButton: RegularButton!
    @IBOutlet var timerLabel: BoldLabel!
    @IBOutlet var cancelButton: RegularButton!
    
    private var startingTime: TimeInterval = 0
    private var viewModel: TimerViewModel!
    
    // MARK: - Init
    
    static func createControllerFor(time: TimeInterval) -> TimerController {
        let storyboard = UIStoryboard(name: "Timer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TimerController.storyboardId) as! TimerController
        controller.startingTime = time
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TimerViewModel(prepTime: 10, startTime: startingTime, step: 1, prepTimeUpdated: { [unowned self] time, formattedTime in
            if time <= 1 {
                AlarmManager.shared.playBeginTimer()
            } else {
                AlarmManager.shared.playTick()
            }
            self.timerLabel.text = "STARTING IN \(formattedTime)"
        }, timeUpdated: { [unowned self] time, formattedTime in
            self.timerLabel.text = formattedTime
            if time == 0 {
                self.completeTimer()
            }
        }, timerToggled: { [unowned self] paused in
            let playPauseImage = paused == true ? "Play" : "Pause"
            self.playPauseButton.setImage(UIImage(named: playPauseImage), for: .normal)
        })
        setupUI()
        viewModel.toggleTimer()
    }
    
    private func setupUI() {
        cancelButton.setImage(cancelButton.image(for: .normal)?.maskedWithColor(UIColor.appTextSecondary(for: traitCollection)), for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func playPauseTapped(_ sender: AnyObject) {
        viewModel.toggleTimer()
    }
    
    @IBAction func cancelTapped(_ sender: AnyObject) {
        viewModel.cancelTimer()
        self.navigationController?.popViewController(animated: true)
        AlarmManager.shared.endAlarm()
    }
    
    // MARK: - Helpers
    
    private func completeTimer() {
        self.playPauseButton.isHidden = true
        viewModel.cancelTimer()
        AlarmManager.shared.playAlarm()
    }
    
}
