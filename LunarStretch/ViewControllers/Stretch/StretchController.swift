//
//  StretchController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class StretchController: BaseViewController {
 
    // MARK: - Properties
    
    static let storyboardId = "StretchControllerId"
    
    var stretch: ScheduleStretch!
    
    // MARK: - Init
    
    static func createControllerFor(stretch: ScheduleStretch) -> StretchController {
        let storyboard = UIStoryboard(name: "Stretch", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StretchController.storyboardId) as! StretchController
        controller.stretch = stretch
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = "STRETCH"
    }
    
}
