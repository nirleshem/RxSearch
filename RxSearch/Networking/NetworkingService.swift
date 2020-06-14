//
//  Networking.swift
//  RxSearch
//
//  Created by Nir Leshem on 12/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import Foundation
import RxSwift

class NetworkingService {
    
    private func queryToUrl(for query: String?) -> URL? {
        guard let query = query, query.isEmpty == false else { return nil }
        return URL(string: Constants.Movies.searchUrl + query)
    }

    func search(with query: String) -> Observable<MovieResponse> {
        let emptyResult: MovieResponse = MovieResponse(results: [])
        guard let url = self.queryToUrl(for: query) else { return .just(emptyResult) }
        //print("URL: \(url.absoluteString)")
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("session error: \(error.localizedDescription)")
                    observer.onError(NetworkingError(error: error))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let jsonObj = try JSONDecoder().decode(MovieResponse.self, from: data)
                    observer.onNext(jsonObj)
                    
                } catch let jsonError {
                    observer.onError(jsonError)
                }
                observer.onCompleted()
                
            }
            task.resume()
            
            return Disposables.create { task.cancel() }
        }.catchErrorJustReturn(emptyResult)
    }
}
