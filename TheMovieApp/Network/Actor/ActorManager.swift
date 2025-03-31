//
//  ActorManager.swift
//  TheMovieApp
//
//  Created by ferid on 08.02.25.
//

import Foundation

protocol ActorManagerUseCase {
    func getActorList(page: Int, completion: @escaping((Actor?, String?) -> Void))
    func getActorMovies(actorId: Int, completion: @escaping((Movie?, String?) -> Void))
    func getActorItems(page: Int) async throws -> Actor?
}
extension ActorManagerUseCase {
    func searchActor() {}
}

class ActorManager: ActorManagerUseCase {
    
    let manager = NetworkManager()
    
    func getActorList(page: Int, completion: @escaping((Actor?, String?) -> Void)) {
        let path = ActorEndpoint.actor(page: page).path
        manager.request(path: path, model: Actor.self, completion: completion)
    }
    
    func getActorMovies(actorId: Int, completion: @escaping((Movie?, String?) -> Void)) {
        let path = ActorEndpoint.actorMovies(id: actorId).path
        manager.request(path: path, model: Movie.self, completion: completion)
    }
    
    func getActorItems(page: Int) async throws -> Actor? {
        let path = ActorEndpoint.actor(page: page).path
        return try await manager.request(path: path, model: Actor.self)
    }
    
    
}
