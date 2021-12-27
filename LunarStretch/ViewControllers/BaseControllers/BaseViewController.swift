//
//  BaseViewController.swift
//
//  Created by Eric Ziegler
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties

    var baseNavController: BaseNavigationController? {
        guard let navController = self.navigationController as? BaseNavigationController else {
            return nil
        }
        return navController
    }

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        updateAppearance()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAppearance()
    }

    // MARK: - Helpers

    func updateAppearance() {
        self.navigationController?.navigationBar.titleTextAttributes = navTitleTextAttributes(for: self.view.traitCollection)
        self.view.backgroundColor = UIColor.appBackground(for: traitCollection)
    }

    func showAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
