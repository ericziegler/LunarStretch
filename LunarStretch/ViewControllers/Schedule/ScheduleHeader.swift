//
//  ScheduleHeader.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class ScheduleHeader: UITableViewHeaderFooterView {
 
    // MARK: - Properties
    
    static let reuseId = "ScheduleHeaderId"
    static let standardHeight: CGFloat = 51
    
    var nameLabel: MediumLabel!
    var checkButton: RegularButton!

    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        buildUI()
    }
    
    private func buildUI() {
        self.contentView.backgroundColor = UIColor.appSelection(for: traitCollection)
        
        nameLabel = MediumLabel(frame: .zero)
        nameLabel.textColor = UIColor.appMain(for: traitCollection)
        nameLabel.font = UIFont.appMediumFontOfSize(23)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
        ])
        
        checkButton = RegularButton(type: .custom)
        checkButton.setImage(UIImage(named: "CheckHeader"), for: .normal)
        checkButton.isUserInteractionEnabled = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(checkButton)
        NSLayoutConstraint.activate([
            checkButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            checkButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0)
        ])
    }
    
    // MARK: - Layout
    
    func layoutFor(day: ScheduleDay) {
        if let day = day.day {
            nameLabel.text = "Day \(day)"
        } else {
            nameLabel.text = ""
        }
        checkButton.isHidden = !day.isCompleted
    }
    
}
