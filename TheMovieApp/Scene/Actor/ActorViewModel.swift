//
//  ActorViewModel.swift
//  TheMovieApp
//
//  Created by Samxal Quliyev  on 05.02.25.
//

import Foundation


class ActorViewModel {
    var items = [ActorData]()
    //let manager = ActorManager()
    private var actor: Actor?
    
    var useCase:ActorManagerUseCase
    
    init(useCase: ActorManagerUseCase) {
        self.useCase = useCase
    }
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getActorList() {
        useCase.getActorList(page:(actor?.page ?? 0) + 1 ) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.actor = data
                //self.items = data.results ?? []
                self.items.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
    
    func getActorItems() async {
        do {
            let data = try await useCase.getActorItems(page:(actor?.page ?? 0) + 1 )
            items.append(contentsOf: data?.results ?? [])
            Task { @MainActor in
                success?()
            }
        } catch {
            Task { @MainActor in
                self.error?(error.localizedDescription)
            }
        }
    }
    
    func pagination(index: Int) {
        if index == items.count - 2 && (actor?.page ?? 0 <= actor?.totalPages ?? 0) {
            getActorList()
        }
    }
    func reset() {
        actor = nil
        items.removeAll()
    }
}
