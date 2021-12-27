//
//  ScheduleCell.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class ScheduleCell: UITableViewCell {
 
    // MARK: - Properties
    
    static let reuseId = "ScheduleCellId"
    
    @IBOutlet var stretchLabel: MediumLabel!
    @IBOutlet var durationLabel: RegularLabel!
    
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
    }
    
}
