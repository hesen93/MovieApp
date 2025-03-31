//
//  MovieDetailsViewModel.swift
//  TheMovieApp
//
//  Created by ferid on 11.02.25.
//

import Foundation

class MovieDetailsViewModel {
    
    var movie:MovieResult?
    var movieDetail:MovieDetails?
    var manager = MovieDetailsManager()
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getMovieDetails() {
        manager.getMovieDetails(movieId: movie?.id ?? 0) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
                print(errorMessage)
            } else if let data {
                self.movieDetail = data
                print(self.movieDetail ?? [])
                self.success?()
            }
        }
    }
}
