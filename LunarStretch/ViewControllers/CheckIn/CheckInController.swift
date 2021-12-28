//
//  CheckInController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/28/21.
//

import UIKit

// MARK: - Protocols

protocol CheckInControllerDelegate {
    func checkInSavedFor(stretch: ScheduleStretch, controller: CheckInController)
    func checkInControllerWillDismiss(controller: CheckInController)
}

class CheckInController: BaseViewController {
 
    // MARK: - Properties
    
    static let storyboardId = "CheckInControllerId"
    
    @IBOutlet var leftFrontField: AppTextField!
    @IBOutlet var rightFrontField: AppTextField!
    @IBOutlet var leftSideField: AppTextField!
    @IBOutlet var rightSideField: AppTextField!
    @IBOutlet var leftRoundhouseField: AppTextField!
    @IBOutlet var rightRoundhouseField: AppTextField!
    
    private var stretch: ScheduleStretch!
    private var day = 0
    private var checkIn = CheckIn()
    var delegate: CheckInControllerDelegate?
    
    // MARK: - Init
    
    static func createControllerFor(stretch: ScheduleStretch, day: Int) -> CheckInController {
        let storyboard = UIStoryboard(name: "CheckIn", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: CheckInController.storyboardId) as! CheckInController
        controller.stretch = stretch
        controller.day = day
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTempModel()
        populateUIFromModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.checkInControllerWillDismiss(controller: self)
    }
    
    private func setupTempModel() {
        if let stretchCheckIn = stretch.checkIn {
            checkIn.day = stretchCheckIn.day
            checkIn.frontLeft = stretchCheckIn.frontLeft
            checkIn.frontRight = stretchCheckIn.frontRight
            checkIn.sideLeft = stretchCheckIn.sideLeft
            checkIn.sideRight = stretchCheckIn.sideRight
            checkIn.roundhouseLeft = stretchCheckIn.roundhouseLeft
            checkIn.roundhouseRight = stretchCheckIn.roundhouseRight
        }
    }
    
    private func setupUI() {
        self.title = "CHECK IN - DAY \(day)"
        
        leftFrontField.backgroundColor = UIColor.appBar(for: traitCollection)
        rightFrontField.backgroundColor = UIColor.appBar(for: traitCollection)
        leftSideField.backgroundColor = UIColor.appBar(for: traitCollection)
        rightSideField.backgroundColor = UIColor.appBar(for: traitCollection)
        leftRoundhouseField.backgroundColor = UIColor.appBar(for: traitCollection)
        rightRoundhouseField.backgroundColor = UIColor.appBar(for: traitCollection)
        
        leftFrontField.textColor = UIColor.appText(for: traitCollection)
        rightFrontField.textColor = UIColor.appText(for: traitCollection)
        leftSideField.textColor = UIColor.appText(for: traitCollection)
        rightSideField.textColor = UIColor.appText(for: traitCollection)
        leftRoundhouseField.textColor = UIColor.appText(for: traitCollection)
        rightRoundhouseField.textColor = UIColor.appText(for: traitCollection)
    }
    
    private func populateUIFromModel() {
        if let frontLeft = checkIn.frontLeft {
            leftFrontField.text = String(frontLeft)
        }
        if let frontRight = checkIn.frontRight {
            rightFrontField.text = String(frontRight)
        }
        if let sideLeft = checkIn.sideLeft {
            leftSideField.text = String(sideLeft)
        }
        if let sideRight = checkIn.sideRight {
            rightSideField.text = String(sideRight)
        }
        if let roundhouseLeft = checkIn.roundhouseLeft {
            leftRoundhouseField.text = String(roundhouseLeft)
        }
        if let roundhouseRight = checkIn.roundhouseRight {
            rightRoundhouseField.text = String(roundhouseRight)
        }
    }
    
    private func populateModelFromUI() {
        if let leftFront = leftFrontField.text {
            checkIn.frontLeft = Double(leftFront)
        } else {
            checkIn.frontLeft = nil
        }
        if let rightFront = rightFrontField.text {
            checkIn.frontRight = Double(rightFront)
        } else {
            checkIn.frontRight = nil
        }
        if let leftSide = leftSideField.text {
            checkIn.sideLeft = Double(leftSide)
        } else {
            checkIn.sideLeft = nil
        }
        if let rightSide = rightSideField.text {
            checkIn.sideRight = Double(rightSide)
        } else {
            checkIn.sideRight = nil
        }
        if let leftRoundhouse = leftRoundhouseField.text {
            checkIn.roundhouseLeft = Double(leftRoundhouse)
        } else {
            checkIn.roundhouseLeft = nil
        }
        if let rightRoundhouse = rightRoundhouseField.text {
            checkIn.roundhouseRight = Double(rightRoundhouse)
        } else {
            checkIn.roundhouseRight = nil
        }
    }
    
    // MARK: - Actions
    
    @IBAction func saveTapped(_ sender: AnyObject) {
        populateModelFromUI()
        stretch.checkIn = checkIn
        delegate?.checkInSavedFor(stretch: stretch, controller: self)
        self.navigationController?.popViewController(animated: true)
    }
    
}
