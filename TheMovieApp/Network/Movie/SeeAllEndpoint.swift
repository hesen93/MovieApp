//
//  SeeAllEndpoint.swift
//  TheMovieApp
//
//  Created by ferid on 27.02.25.
//

import Foundation
enum SeeAllEndpoint{
    
    case seeAll(path: String, page: Int)
    
    var path: String {
        switch self {
           
        case .seeAll(path: let path, page: let page):
            "\(path)?page=\(page)"
        }
    }
}
