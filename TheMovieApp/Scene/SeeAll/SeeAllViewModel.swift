//
//  SeeAllViewModel.swift
//  TheMovieApp
//
//  Created by ferid on 27.02.25.
//

import Foundation

class SeeAllViewModel {
    
    var movies =  [MovieResult]()
    var titleItem: String?
    var endpoint: String?
    private var movie: Movie?
    private let useCase = MovieManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getMovies() {
        useCase.getMovies(path: endpoint ?? "", page:(movie?.page ?? 1) + 1 ) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                print(data.page!)
                self.movie = data
                self.movies.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
    func pagination(index: Int) {
        if index == (movies.count) - 1 && (movie?.page ?? 1 <= movie?.totalPages ?? 1) {
            getMovies()
        }
    }
}


