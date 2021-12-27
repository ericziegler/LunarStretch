//
//  ScheduleController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class ScheduleController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
 
    // MARK: - Properties
    
    static let storyboardId = "ScheduleControllerId"
    
    @IBOutlet var scheduleTable: UITableView!
    
    private lazy var viewModel: ScheduleViewModel = {
       return ScheduleViewModel()
    }()
    
    // MARK: - Init
    
    static func createController() -> ScheduleController {
        let storyboard = UIStoryboard(name: "Schedule", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ScheduleController.storyboardId) as! ScheduleController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = "SCHEDULE"
        if #available(iOS 15.0, *) {
            scheduleTable.sectionHeaderTopPadding = 0
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.days.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let curDay = viewModel.days[section]
        return curDay.stretches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseId, for: indexPath) as! ScheduleCell
        let curDay = viewModel.days[indexPath.section]
        if let stretches = curDay.stretches {
            let curStretch = stretches[indexPath.row]
            cell.layoutFor(stretch: curStretch)
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ScheduleHeaderCell.standardHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: ScheduleHeaderCell.reuseId) as! ScheduleHeaderCell
        let curDay = viewModel.days[section]
        header.layoutFor(day: curDay)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
