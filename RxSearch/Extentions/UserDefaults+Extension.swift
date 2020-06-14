//
//  UserDefaults+Extension.swift
//  RxSearch
//
//  Created by Nir Leshem on 13/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import Foundation

extension UserDefaults {

    var filterState: FilterState {
        get {
            return FilterState(rawValue: self.integer(forKey: "filterState")) ?? .name//self.value(forKey: "filterState") as? FilterState
        }
        set {
            self.set(newValue.rawValue, forKey: "filterState")//self.set(newValue, forKey: "filterState")
        }
    }
}
