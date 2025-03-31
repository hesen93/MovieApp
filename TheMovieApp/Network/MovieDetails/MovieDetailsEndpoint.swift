//
//  MovieDetailsEndpoint.swift
//  TheMovieApp
//
//  Created by ferid on 11.02.25.
//

import Foundation
enum MovieDetailsEndpoint{
    case movieID(id: Int)
    
    var path: String {
        
        switch self {
            
        case .movieID(let id):
            print(NetworkHelper.shared.configureURL(endpoint: "movie/\(id)"))
            return NetworkHelper.shared.configureURL(endpoint: "movie/\(id)")
            
        }
        
    }
}
