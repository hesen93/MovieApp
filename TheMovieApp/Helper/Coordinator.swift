//
//  Coordinator.swift
//  TheMovieApp
//
//  Created by ferid on 28.02.25.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController:UINavigationController { get }
    
    func start()
}
