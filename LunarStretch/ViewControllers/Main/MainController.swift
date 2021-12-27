//
//  MainController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class MainController: BaseViewController {
 
    // MARK: - Properties
    
    static let storyboardId = "MainControllerId"
    
    @IBOutlet var navigationContainer: UIView!
    @IBOutlet var timePickerContainer: UIView!
    
    private lazy var scheduleController = {
        ScheduleController.createController()
    }()
    private lazy var timePickerController =  {
        TimePickerController.createController()
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        let scheduleNavController = BaseNavigationController(rootViewController: scheduleController)
        self.addChild(scheduleNavController)
        scheduleNavController.view.fillInParentView(parentView: navigationContainer)
        scheduleNavController.didMove(toParent: self)
        
        let timeNavController = BaseNavigationController(rootViewController: timePickerController)
        self.addChild(timeNavController)
        timeNavController.setNavigationBarHidden(true, animated: false)
        timeNavController.view.fillInParentView(parentView: timePickerContainer)
        timeNavController.didMove(toParent: self)
    }
    
}
