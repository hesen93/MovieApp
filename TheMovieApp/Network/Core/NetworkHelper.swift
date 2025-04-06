//
//  NetworkHelper.swift
//  TheMovieApp
//
//  Created by Samxal Quliyev  on 31.01.25.
//

import Foundation
import Alamofire

enum EncodingType {
    case url
    case json
}


class NetworkHelper { 
    static let shared = NetworkHelper()
    
    let baseURL = "https://api.themoviedb.org/3/"
    let baseImageUrl = "https://image.tmdb.org/t/p/original"
    let header: HTTPHeaders = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjI1MzQxNmZhYzBjZDI0NzYyOTFlYjMzYzkyYmViNyIsIm5iZiI6MTY0ODYyMDAzNC4xNTgwMDAyLCJzdWIiOiI2MjQzZjIwMmM1MGFkMjAwNWNkZTk1ZjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.xs9Bib0qWPDMeB9YXyPkYa4CzmQ5W4-N6rgdaLRPlZc"]
    
    func configureURL(endpoint: String, page: Int = 1) -> String{
        return baseURL + endpoint
    }
    
}
