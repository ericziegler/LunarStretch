//
//  ScheduleHeaderCell.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class ScheduleHeaderCell: UITableViewCell {
 
    // MARK: - Properties
    
    static let reuseId = "ScheduleHeaderCellId"
    static let standardHeight: CGFloat = 51
    
    @IBOutlet var nameLabel: MediumLabel!
    
    // MARK: - Layout
    
    func layoutFor(day: ScheduleDay) {
        if let day = day.day {
            nameLabel.text = "Day \(day)"
        } else {
            nameLabel.text = ""
        }
    }
    
}
