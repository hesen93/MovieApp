//
//  MovieManager.swift
//  TheMovieApp
//
//  Created by ferid on 11.02.25.
//

import Foundation
protocol MovieManagerUseCase {
    func getMovies(for category: String, path: String, completion: @escaping (Movie?, String?) -> Void)
    func getMovies(path: String,page: Int, completion: @escaping((Movie?, String?) -> Void))

}

class MovieManager:MovieManagerUseCase {
    
    let manager = NetworkManager()
    
    func getMovies(for category: String = "", path: String, completion: @escaping (Movie?, String?) -> Void) {
        manager.request(path: path, model: Movie.self, completion: completion)
    }
    func getMovies(path: String, page: Int, completion: @escaping ((Movie?, String?) -> Void)) {
        let fullPath = SeeAllEndpoint.seeAll(path: path, page: page).path

        manager.request(path: fullPath, model: Movie.self, completion: completion)
    }
}
