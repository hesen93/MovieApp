//
//  Extension.swift
//  TheMovieApp
//
//  Created by ferid on 05.02.25.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url:String) {
        let imageUrlData = NetworkHelper.shared.baseImageUrl + url
        if let imageUrl = URL(string: imageUrlData) {
            self.kf.setImage(with: imageUrl)
        }
    }
}

extension UIViewController {
    func showAlert(title: String = "Error ",
                   message: String? = nil,
                   actionTitle:String = "Ok") {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        controller.addAction(action)
        present(controller, animated: true)
    }
}

