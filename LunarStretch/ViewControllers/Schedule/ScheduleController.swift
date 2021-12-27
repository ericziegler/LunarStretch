//
//  ScheduleController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class ScheduleController: BaseViewController, UITableViewDataSource, UITableViewDelegate, ScheduleCellDelegate, StretchControllerDelegate {
 
    // MARK: - Properties
    
    static let storyboardId = "ScheduleControllerId"
    
    @IBOutlet var scheduleTable: UITableView!
    
    private lazy var viewModel: ScheduleViewModel = {
       return ScheduleViewModel()
    }()
    private var selectedIndexPath: IndexPath?
    
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
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoTapped(_:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        scheduleTable.register(ScheduleHeader.self, forHeaderFooterViewReuseIdentifier: ScheduleHeader.reuseId)
    }
    
    // MARK: - Actions
    
    @IBAction func infoTapped(_ sender: AnyObject) {
        let statsMessage = "\(viewModel.dayProgress)\n\(viewModel.stretchProgress)"
        let alert = UIAlertController(title: "Your Stats", message: statsMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        if let curStretch = stretchAt(indexPath: indexPath) {
            cell.layoutFor(stretch: curStretch)
            cell.delegate = self
        }
        return cell
    }
    
    // MARK: - Helpers
    
    private func stretchAt(indexPath: IndexPath) -> ScheduleStretch? {
        let curDay = viewModel.days[indexPath.section]
        if let stretches = curDay.stretches {
            return stretches[indexPath.row]
        }
        return nil
    }
    
    private func toggleStretchCompletedAt(indexPath: IndexPath) {
        guard let curStretch = stretchAt(indexPath: indexPath)  else {
            return
        }
        curStretch.isCompleted = !curStretch.isCompleted
        viewModel.saveSchedule()
        scheduleTable.reloadSections(IndexSet(integer: indexPath.section), with: .none)
        playHaptic()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ScheduleHeader.standardHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScheduleHeader.reuseId) as! ScheduleHeader
        let curDay = viewModel.days[section]
        header.layoutFor(day: curDay)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let curStretch = stretchAt(indexPath: indexPath)  else {
            return
        }
        selectedIndexPath = indexPath
        
        let controller = StretchController.createControllerFor(stretch: curStretch)
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: nil) { [unowned self] (action, view, completionHandler) in
            self.toggleStretchCompletedAt(indexPath: indexPath)
        }
        completeAction.backgroundColor = UIColor.appMain(for: traitCollection)
        completeAction.image = UIImage(systemName: "checkmark")
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    // MARK: - ScheduleCellDelegate
    
    func checkTappedFor(cell: ScheduleCell) {
        guard let indexPath = scheduleTable.indexPath(for: cell) else {
            return
        }
        toggleStretchCompletedAt(indexPath: indexPath)
    }
    
    // MARK: - StretchControllerDelegate
    
    func stretchCompletionToggled(stretch: ScheduleStretch, controller: StretchController) {
        guard let indexPath = selectedIndexPath else {
            return
        }
        
        toggleStretchCompletedAt(indexPath: indexPath)
    }
    
    func stretchControllerWillDismiss(controller: StretchController) {
        selectedIndexPath = nil
    }
    
}
