//
//  FirestoreManager.swift
//  TheMovieApp
//
//  Created by ferid on 23.02.25.
//

import Foundation
import FirebaseFirestore


class FirestoreManager {
    
    
    
    static let shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func saveMovie(movie:MovieDetails, completion: @escaping((String?) -> Void)) {
        let data: [String: Any] = ["movieId":movie.id ?? 0,
                                   "name":movie.title as Any,
                                   "poster":movie.posterPath as Any]
        guard let collection = UserDefaults.standard.value(forKey: "userId") as? String else {return}
        db.collection(collection).document("\(movie.id ?? 0)").setData(data) { error in
            if let error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchMovies(completion: @escaping ([FavouriteModel]?, String?) -> Void) {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            completion(nil, "User ID not found.")
            return
        }
        db.collection(userId).getDocuments(completion: { data, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }else if let data = data {
                let movies: [FavouriteModel] = data.documents.compactMap { doc in
                    let data = doc.data()
                    return FavouriteModel(
                        id: data["movieId"] as? Int,
                        title: data["name"] as? String,
                        posterPath: data["poster"] as? String
                    )
                }
                completion(movies, nil)
            }
        })
    }
}
