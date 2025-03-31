//
//  MovieDetailsManager.swift
//  TheMovieApp
//
//  Created by ferid on 11.02.25.
//

import Foundation
protocol MovieDetailsManagerUseCase {
    func getMovieDetails(movieId: Int, completion: @escaping((MovieDetails?, String?) -> Void))
}

class MovieDetailsManager:MovieDetailsManagerUseCase {
    let manager = NetworkManager()
    func getMovieDetails(movieId: Int, completion: @escaping ((MovieDetails?, String?) -> Void)) {
        let path = MovieDetailsEndpoint.movieID(id: movieId).path
        manager.request(path: path, model: MovieDetails.self, completion:completion)
    }
}
