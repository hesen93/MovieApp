//
//  MovieDetailCoordinator.swift
//  TheMovieApp
//
//  Created by ferid on 28.02.25.
//

import Foundation
import UIKit

final class MovieDetailCoordinator:Coordinator {
    var navigationController: UINavigationController
    var movie: MovieResult
    
    init(movie:MovieResult, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailController") as! MovieDetailController
        controller.viewModel.movie = movie
        navigationController.show(controller, sender: nil)
    }
    
    
}
