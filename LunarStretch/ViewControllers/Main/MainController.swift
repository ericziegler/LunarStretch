//
//  MainController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class MainController: UIViewController {
 
    // MARK: - Properties
    
    static let storyboardId = "MainControllerId"
    
    @IBOutlet var navigationContainer: UIView!
    @IBOutlet var timerContainter: UIView!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        // TODO: EZ - Create schedule controller, timer controller. Place in containers.
    }
    
}
