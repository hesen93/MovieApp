//
//  HomeViewModel.swift
//  TheMovieApp
//
//  Created by ferid on 01.02.25.
//

import Foundation

struct HomeModel {
    let title: String
    let items: [MovieResult]
    let endpoint: String
}

class HomeViewModel {
    
    private let useCase = MovieManager()
    var movieItems = [HomeModel]()
    var success: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    var endpoint:String?
    
    private let categories: [(String, String)] = [
        ("Popular", MovieEndpoint.popular.path),
        ("Now Playing", MovieEndpoint.nowPlaying.path),
        ("Top Rated", MovieEndpoint.topRated.path),
        ("Upcoming", MovieEndpoint.upcoming.path)
    ]
    
    func getAllData() {
        for (title, path) in categories {
            useCase.getMovies(for: title, path: path) { data, error in
                if let error = error {
                    self.errorHandling?(error)
                } else if let data = data {
                    self.movieItems.append(HomeModel(title: title, items: data.results ?? [], endpoint: path))
                    self.success?()
                    self.endpoint = path
                    
                }
            }
        }
    }
}

//    func getAllData() {
//        let categories: [(String, String)] = [
//            ("Popular", MovieEndpoint.popular.path),
//            ("Now Playing", MovieEndpoint.nowPlaying.path),
//            ("Top Rated", MovieEndpoint.topRated.path),
//            ("Upcoming", MovieEndpoint.upcoming.path)
//        ]
//        
//        for (title, path) in categories {
//            fetchMovies(category: title, path: path)
//        }
//    }
//    
//    private func fetchMovies(category: String, path: String) {
//        manager.request(path: path,
//                        model: Movie.self) { data, error in
//            if let error {
//                self.errorHandling?(error)
//            } else if let data {
//                self.movieItems.append(.init(title: category,
//                                             items: data.results ?? []))
//                self.success?()
//            }
//        }
//    }
//    
//    func getNowPlaying() {
//        let path = MovieEndpoint.nowPlaying.path
//        manager.request (path: path ,
//                         model: Movie.self) { data, error in
//            if let error {
//                self.errorHandling?(error)
//            }else if let data {
//                self.movieItems.append(.init(title: "Now Playing",
//                                             items: data.results ?? []))
//                self.success?()
//            }
//        }
//    }
//    private func getPopular() {
//        let path = MovieEndpoint.popular.path
//        manager.request (path: path ,
//                        model: Movie.self) { data, error in
//            if let error {
//                self.errorHandling?(error)
//            } else if let data {
//                self.movieItems.append(.init(title: "Popular",
//                                             items: data.results ?? []))
//                print(path)
//                self.success?()
//            }
//        }
//    }
//    
//    private func getTopRated() {
//        let path = MovieEndpoint.topRated.path
//        manager.request (path: path ,
//                        model: Movie.self) { data, error in
//            if let error {
//                self.errorHandling?(error)
//            } else if let data {
//                self.movieItems.append(.init(title: "Top Rated",
//                                             items: data.results ?? []))
//                self.success?()
//            }
//        }
//    }
//    
//    private func getUpcoming() {
//        let path = MovieEndpoint.upcoming.path
//        manager.request (path: path ,
//                        model: Movie.self) { data, error in
//            if let error {
//                self.errorHandling?(error)
//            } else if let data {
//                self.movieItems.append(.init(title: "Upcoming",
//                                             items: data.results ?? []))
//                self.success?()
//            }
//        }
//    }
//}
