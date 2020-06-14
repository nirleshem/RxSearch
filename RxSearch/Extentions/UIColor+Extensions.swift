//
//  UIColor+Extensions.swift
//  RxSearch
//
//  Created by Nir Leshem on 13/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import UIKit

extension UIColor {

    class func colorWithHex(hex: Int) -> CGColor {
        return UIColor(hex: hex).cgColor
    }
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    class func getButtonBgColorOn() -> UIColor {
        return UIColor(red: 0.27, green: 0.45, blue: 0.77, alpha: 1.00)
    }
}
