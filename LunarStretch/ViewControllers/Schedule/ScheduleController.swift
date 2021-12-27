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
        self.title = "SCHEDULE"
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: EZ- Implement
        return 0
        return viewModel.days.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TOOD: EZ - Implement
        return 0
        let curDay = viewModel.days[section]
        return curDay.stretches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
