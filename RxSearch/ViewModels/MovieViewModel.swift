//
//  MovieViewModel.swift
//  RxSearch
//
//  Created by Nir Leshem on 13/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import UIKit

protocol MovieViewModelable {
    var name: String { get }
    var rating: Double { get }
}

struct MovieViewModel: MovieViewModelable {
    var name: String
    var rating: Double
    
    func getScoreColor() -> UIColor {
        switch rating {
        case 7.5...:
            return UIColor.init(hex: 0x60f204)
        case 6..<7.5:
            return UIColor.init(hex: 0xe78f08)
        case 0..<6:
            return UIColor.init(hex: 0xf60a0a)
        default:
            return .white
        }
    }
}
