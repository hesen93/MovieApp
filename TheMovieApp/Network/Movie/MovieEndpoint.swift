//
//  MovieEndpoint.swift
//  TheMovieApp
//
//  Created by Samxal Quliyev  on 05.02.25.
//

import Foundation

enum MovieEndpoint: String {
    case nowPlaying = "movie/now_playing"
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    
    var path: String {

        NetworkHelper.shared.configureURL(endpoint: self.rawValue)
    }
}
