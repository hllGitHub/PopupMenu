//
//  Extension.swift
//  PopMenu
//
//  Created by liangliang hu on 2020/8/27.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
    self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
  }

  convenience init(hexString: String, alpha: CGFloat = 1.0) {
    var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

    if hexFormatted.hasPrefix("#") {
      hexFormatted = String(hexFormatted.dropFirst())
    }

    assert(hexFormatted.count == 6, "Invalid hex code used.")

    var rgbValue: UInt64 = 0
    Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

  static var random: UIColor {
    return UIColor(red: .random(in: 0...1),
                   green: .random(in: 0...1),
                   blue: .random(in: 0...1),
                   alpha: 1.0)
  }
}

public extension UIApplication {
  var statusHeight: CGFloat {
    if #available(iOS 13.0, *) {
      return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
      return UIApplication.shared.statusBarFrame.height
    }
  }

  var window: UIWindow? {
    if #available(iOS 13.0, *) {
      return UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    } else {
      return UIApplication.shared.keyWindow
    }
  }
}
