//
//  FavouriteController.swift
//  TheMovieApp
//
//  Created by ferid on 23.02.25.
//

import UIKit

class FavouriteController: UIViewController  {

    private var collectionView: UICollectionView!
    private let viewModel = FavouriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureViewModel()
        viewModel.fetchFavouriteMovies()
    }
    
    private func configureViewModel() {
        viewModel.success = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white

        collectionView.register(ImageLabelCell.self, forCellWithReuseIdentifier: "ImageLabelCell")
        view.addSubview(collectionView)
    }
}
extension FavouriteController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favouriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLabelCell", for: indexPath) as? ImageLabelCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.favouriteMovies[indexPath.item]
        cell.configure(data: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 400)
    }
}
