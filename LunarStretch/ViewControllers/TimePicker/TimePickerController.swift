//
//  TimePickerController.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import UIKit

class TimePickerController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
 
    // MARK: - Properties
    
    static let storyboardId = "TimePickerControllerId"
    
    @IBOutlet var pickerCollection: UICollectionView!
    
    lazy var viewModel = {
       TimePickerViewModel()
    }()
    
    // MARK: - Init
    
    static func createController() -> TimePickerController {
        let storyboard = UIStoryboard(name: "TimePicker", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TimePickerController.storyboardId) as! TimePickerController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }
    
    private func setupCollection() {
        let spacing: CGFloat = 0
        let columnCount = viewModel.timeCount
        let flowLayout =  TimePickerCollectionFlowLayout(
            cellsPerRow: columnCount,
            cellHeight: pickerCollection.bounds.height,
            minimumInteritemSpacing: spacing,
            minimumLineSpacing: spacing,
            sectionInset: UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        )
        pickerCollection.collectionViewLayout = flowLayout
        pickerCollection.contentInsetAdjustmentBehavior = .always
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.timeCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimePickerCell.reuseId, for: indexPath) as! TimePickerCell
        let time = viewModel.formattedTimeAt(index: indexPath.row)
        cell.timeLabel.text = time
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let timerController = TimerController.createControllerFor(time: self.viewModel.times[indexPath.row])
            self.navigationController?.pushViewController(timerController, animated: true)
        }
    }
    
}
