//
//  TimerController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class TimerController: BaseViewController {
    
    // MARK: - Properties
    
    static let storyboardId = "TimerControllerId"
    
    // MARK: - Init
    
    static func createController() -> TimerController {
        let storyboard = UIStoryboard(name: "Timer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TimerController.storyboardId) as! TimerController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TODO: EZ - Remove
    override func updateAppearance() {
        self.view.backgroundColor = UIColor.systemPink
    }
    
}
