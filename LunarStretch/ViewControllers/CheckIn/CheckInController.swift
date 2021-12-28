//
//  CheckInController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/28/21.
//

import UIKit

class CheckInController: BaseViewController {
 
    // MARK: - Properties
    
    static let storyboardId = "CheckInControllerId"
    
    @IBOutlet var leftFrontField: AppTextField!
    @IBOutlet var rightFrontField: AppTextField!
    @IBOutlet var leftSideField: AppTextField!
    @IBOutlet var rightSideField: AppTextField!
    @IBOutlet var leftRoundhouseField: AppTextField!
    @IBOutlet var rightRoundhouseField: AppTextField!
    
    // MARK: - Init
    
    static func createController() -> CheckInController {
        let storyboard = UIStoryboard(name: "CheckIn", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: CheckInController.storyboardId) as! CheckInController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = "CHECK IN"
    }
    
    // MARK: - Actions
    
    @IBAction func saveTapped(_ sender: AnyObject) {
        // TODO: EZ - Save
        self.navigationController?.popViewController(animated: true)
    }
    
}
