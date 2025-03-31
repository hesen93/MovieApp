//
//  FavouriteModel.swift
//  TheMovieApp
//
//  Created by ferid on 25.02.25.
//

import Foundation

struct FavouriteModel:MovieCellProtocol {
    var id: Int?
    var title: String?
    var posterPath: String?
    
    var titleText: String {
        title ?? ""
    }
    
    var imageURL: String {
        posterPath ?? ""
    }
}
