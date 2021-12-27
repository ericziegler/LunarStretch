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
    @IBOutlet var timerContainer: UIView!
    
    private lazy var scheduleController = {
        ScheduleController.createController()
    }()
    private lazy var timerController =  {
        TimerController.createController()
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        let navController = BaseNavigationController(rootViewController: scheduleController)
        navController.view.fillInParentView(parentView: navigationContainer)
        timerController.view.fillInParentView(parentView: timerContainer)
    }
    
}
