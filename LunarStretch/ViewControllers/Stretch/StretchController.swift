//
//  StretchController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit
import WebKit

// MARK: - Protocols

protocol StretchControllerDelegate {
    func stretchCompletionToggled(stretch: ScheduleStretch, controller: StretchController)
    func stretchControllerWillDismiss(controller: StretchController)
}

class StretchController: BaseViewController {
 
    // MARK: - Properties
    
    static let storyboardId = "StretchControllerId"
    
    @IBOutlet var playerView: WKWebView!
    @IBOutlet var nameLabel: LightLabel!
    @IBOutlet var durationLabel: MediumLabel!
    @IBOutlet var completeButton: ActionButton!
    
    private var stretch: ScheduleStretch!
    var delegate: StretchControllerDelegate?
    
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
        loadVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.stretchControllerWillDismiss(controller: self)
    }
    
    private func setupUI() {
        self.title = "STRETCH"
        nameLabel.text = stretch.stretchInfo?.name?.capitalized
        durationLabel.text = stretch.duration?.capitalized
        updateCompleteButton()
    }
    
    private func loadVideo() {
        guard let video = stretch.stretchInfo?.video, let videoURL = URL(string: video) else {
            return
        }
        let request = URLRequest(url: videoURL)
        playerView.load(request)
    }
    
    // MARK: - Actions
    
    @IBAction func completeTapped(_ sender: AnyObject) {
        delegate?.stretchCompletionToggled(stretch: stretch, controller: self)
        updateCompleteButton()
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    private func updateCompleteButton() {
        let completeText = stretch.isCompleted == true ? "MARK INCOMPLETE" : "COMPLETE"
        completeButton.setTitle(completeText, for: .normal)
    }
    
}
