//
//  FavouriteViewModel.swift
//  TheMovieApp
//
//  Created by ferid on 25.02.25.
//

import Foundation

class FavouriteViewModel {

    private(set) var favouriteMovies: [FavouriteModel] = []

    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func fetchFavouriteMovies() {
        FirestoreManager.shared.fetchMovies { movies, error in
            if let error = error {
                self.error?(error)
            } else if let movies = movies {
                self.favouriteMovies = movies
                self.success?()
            }
        }
    }
}
