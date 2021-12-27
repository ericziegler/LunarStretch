//
//  ScheduleCell.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

// MARK: - Protocols

protocol ScheduleCellDelegate {
    func checkTappedFor(cell: ScheduleCell)
}

class ScheduleCell: UITableViewCell {
 
    // MARK: - Properties
    
    static let reuseId = "ScheduleCellId"
    
    @IBOutlet var stretchLabel: MediumLabel!
    @IBOutlet var durationLabel: RegularLabel!
    @IBOutlet var checkButton: RegularButton!
    
    var delegate: ScheduleCellDelegate?
    
    // MARK: - Layout
    
    func layoutFor(stretch: ScheduleStretch) {
        if let name = stretch.stretchInfo?.name {
            if name.contains("rest day") {
                stretchLabel.text = name.uppercased()
            } else {
                stretchLabel.text = name.capitalized
            }
        }
        durationLabel.text = stretch.duration?.capitalized
        
        let checkImage = stretch.isCompleted == true ? "Checked" : "Unchecked"
        checkButton.setImage(UIImage(named: checkImage), for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func checkTapped(_ sender: AnyObject) {
        delegate?.checkTappedFor(cell: self)
    }
    
}
