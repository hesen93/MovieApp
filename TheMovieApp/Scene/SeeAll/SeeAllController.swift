//
//  SeeAllController.swift
//  TheMovieApp
//
//  Created by Samxal Quliyev  on 05.02.25.
//

import UIKit

class SeeAllController: UIViewController {
    
   
    @IBOutlet weak var collection: UICollectionView!
    
    var viewModel = SeeAllViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
    }

    func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(ImageLabelCell.self, forCellWithReuseIdentifier: "ImageLabelCell")
        navigationItem.title = viewModel.titleItem
    }
    func configureViewModel() {

        viewModel.error = { errorMessage in
            print("Error: \(errorMessage)")
        }
        viewModel.success = {
            self.collection.reloadData()
            
        }
    }
}

extension SeeAllController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLabelCell", for: indexPath) as! ImageLabelCell
        let movie = viewModel.movies[indexPath.item] 
        cell.configure(data: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     // let controller = storyboard?.instantiateViewController(identifier: "MovieDetailController") as! MovieDetailController
//        controller.viewModel.movie = viewModel.movies[indexPath.item]
//        navigationController?.show(controller, sender: nil)
        let coordinator = MovieDetailCoordinator(movie: viewModel.movies[indexPath.item], navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 500, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
}
