//
//  Movie.swift
//  RxSearch
//
//  Created by Nir Leshem on 12/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let name: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case rating = "vote_average"
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]?
}
