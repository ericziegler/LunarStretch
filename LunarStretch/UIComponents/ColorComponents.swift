//
//  ColorComponents.swift
//
//  Created by Eric Ziegler
//

import UIKit

extension UITraitCollection {

    class var lightTraitCollection: UITraitCollection {
        return UITraitCollection(userInterfaceStyle: .light)
    }

    class var darkTraitCollection: UITraitCollection {
        return UITraitCollection(userInterfaceStyle: .dark)
    }

}

extension UIColor {

    // Ignore the trait collection passed in for this app. the colors should remain statically in "dark mode".
    // If we want to add light vs. dark colors, check the traitCollection passed in and pass a different color.
    
    class func appMain(for traitCollection: UITraitCollection) -> UIColor {
        return UIColor(hex: 0xdc4548)
    }

    class func appBackground(for traitCollection: UITraitCollection) -> UIColor {
        return UIColor(hex: 0x000000)
    }

    class func appBar(for traitCollection: UITraitCollection) -> UIColor {
        return UIColor(hex: 0x1a1a1a)
    }

    class func appText(for traitCollection: UITraitCollection) -> UIColor {
        return UIColor(hex: 0xffffff)
    }

    class func appTextSecondary(for traitCollection: UITraitCollection) -> UIColor {
        return UIColor(hex: 0x777777)
    }

    class func appSeparator(for traitCollection: UITraitCollection) -> UIColor {
        return UIColor(hex: 0x262626)
    }

    class func appSelection(for traitCollection: UITraitCollection) -> UIColor {
        return UIColor(hex: 0x111111)
    }

    class func appPlaceholder(for traitCollection: UITraitCollection) -> UIColor {
        return UIColor(hex: 0x333333)
    }

}
