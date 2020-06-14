//
//  Constants.swift
//  RxSearch
//
//  Created by Nir Leshem on 12/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import Foundation

struct Constants {

    private static let baseUrl = "https://api.themoviedb.org"
    private static let search = "/3/search/movie?api_key="
    private static let apiKey = "95ae343da96f5b4147a1198ce2b13cba"
    private static let query = "&query="
    
    struct Movies {
        static let searchUrl = Constants.baseUrl + Constants.search + Constants.apiKey + Constants.query
    }
}
