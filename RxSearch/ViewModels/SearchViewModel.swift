//
//  MovieViewModel.swift
//  RxSearch
//
//  Created by Nir Leshem on 12/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {

    let disposeBag = DisposeBag()
    private let service: NetworkingService
    var movies = [MovieViewModelable]()
    var searchQuery = BehaviorRelay<String>(value: "")
    var dataSource = PublishRelay<[MovieViewModelable]>()
    var currentFilter: FilterState {
        get {
            return UserDefaults.standard.filterState
        }
        set {
            UserDefaults.standard.filterState = newValue
        }
    }
    
    init(service: NetworkingService = NetworkingService()) {
        self.service = service
    }

    func search(with query: String) {
        service.search(with: query).subscribe(onNext: { response in
            guard let movies = response.results else { return }
            self.movies = movies.map {
                MovieViewModel(name: $0.name, rating: $0.rating)
            }
            self.sort()
        }).disposed(by: disposeBag)
    }
    
    func sort() {
        switch self.currentFilter {
        case .name:
            self.dataSource.accept(self.movies.sorted(by: { $0.name < $1.name }))
        case .score:
            self.dataSource.accept(self.movies.sorted(by: { $0.rating > $1.rating }))
        }
    }
}

enum FilterState: Int {
    case name
    case score
}
