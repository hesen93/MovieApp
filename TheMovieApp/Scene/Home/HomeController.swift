//
//  HomeController.swift
//  TheMovieApp
//
//  Created by ferid on 01.02.25.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
       
    }
    
    fileprivate func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
    }
    
    fileprivate func configureViewModel() {
        viewModel.getAllData()
        viewModel.errorHandling = { error in
            
        }
        viewModel.success = {
            self.collection.reloadData()
        }
    }
}
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let model = viewModel.movieItems[indexPath.row]
        cell.configure(title: model.title, data: model.items)
        cell.seeAllCallback = {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "\(SeeAllController.self)") as? SeeAllController else { return }
            controller.viewModel.endpoint = model.endpoint
            controller.viewModel.movies = model.items
            controller.viewModel.titleItem = model.title
            print(model.endpoint)
            self.navigationController?.show(controller, sender: nil)
        }
        cell.movieSelected = { movie in
            let coordinator = MovieDetailCoordinator(movie: movie, navigationController: self.navigationController ?? UINavigationController())
            coordinator.start()
        }
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 340)
    }
    
}
