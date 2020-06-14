//
//  UITableViewCell+Extensions.swift
//  RxSearch
//
//  Created by Nir Leshem on 13/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var id: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}
