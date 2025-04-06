//
//  ActorMockManager.swift
//  TheMovieApp
//
//  Created by Samxal Quliyev  on 07.02.25.
//

import Foundation

class ActorMockManager: ActorManagerUseCase {
    let manager = MockManager()
    
    
    func getActorMovies(actorId: Int, completion: @escaping((Movie?, String?) -> Void)) {
        
    }
    
    func getActorItems(page: Int) async throws -> Actor? {
        nil
    }
    
    func getActorList(page: Int, completion: @escaping ((Actor?, String?) -> Void)) {
        manager.loadFile(fileName: "Actor", type: Actor.self, completion: completion)
    }
}
