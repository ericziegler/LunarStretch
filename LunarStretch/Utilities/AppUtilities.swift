//
//  AppUtilities.swift
//
//  Created by Eric Ziegler
//

import UIKit
import AudioToolbox
import AVFAudio

// MARK: - App Versions

var appVersion: String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

var appBuild: String? {
    return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
}

// MARK: Global UI Properties

func applyApplicationAppearanceProperties(for traitCollection: UITraitCollection) {
    UINavigationBar.appearance().tintColor = UIColor.appMain(for: traitCollection)
    UINavigationBar.appearance().barTintColor = UIColor.appBackground(for: traitCollection)
//    UISearchBar.appearance().setBackgroundImage(UIImage.from(color: UIColor(hex: 0xf4f4f7)), for: .any, barMetrics: .default)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.appMediumFontOfSize(12)], for: .normal)
    UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.appText(for: traitCollection)
    if #available(iOS 15.0, *) {
        UITableView.appearance().sectionHeaderTopPadding = 0
    }
}

func navTitleTextAttributes(for traitCollection: UITraitCollection) -> [NSAttributedString.Key : Any] {
    return [NSAttributedString.Key.font : UIFont.appMediumFontOfSize(20), .foregroundColor : UIColor.appText(for: traitCollection)]
}

// MARK: - Audio

func playHaptic() {
    AudioServicesPlaySystemSound(1519)
}
