//
//  MovieCell.swift
//  TheMovieApp
//
//  Created by Samxal Quliyev  on 31.01.25.
//

import UIKit

protocol MovieCellProtocol {
    var titleText: String { get }
    var imageURL: String { get }
}

class ImageLabelCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            
        configureConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureConstraints() {
            addSubview(ImageView)
            addSubview(titleLabel)

            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                ImageView.topAnchor.constraint(equalTo: topAnchor),
                ImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                ImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                ImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8)
              ])
        }
    
    func configure(data: MovieCellProtocol) {
        titleLabel.text = data.titleText
        ImageView.loadImage(url: data.imageURL)
    }
}

