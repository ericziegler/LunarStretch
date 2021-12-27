//
//  ScheduleController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class ScheduleController: BaseViewController {
 
    // MARK: - Properties
    
    static let storyboardId = "ScheduleControllerId"
    
    // MARK: - Init
    
    static func createController() -> ScheduleController {
        let storyboard = UIStoryboard(name: "Schedule", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ScheduleController.storyboardId) as! ScheduleController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SCHEDULE"
    }
    
    // TODO: EZ - Remove
    
    override func updateAppearance() {
        self.view.backgroundColor = UIColor.systemOrange
    }
    
}
