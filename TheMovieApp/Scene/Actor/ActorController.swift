//
//  ActorController.swift
//  TheMovieApp
//
//  Created by Samxal Quliyev  on 05.02.25.
//

import UIKit

class ActorController: UIViewController {
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = ActorViewModel(useCase: ActorManager())
   
    
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    func configureUI() {
        collection.dataSource = self
        collection.delegate = self
        navigationItem.title = "Actor List"
        collection.register(ImageLabelCell.self, forCellWithReuseIdentifier: "ImageLabelCell")
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        collection.refreshControl = refreshControl
    }
    
    @objc func pullToRefresh() {
        viewModel.reset()
        viewModel.getActorList()
    }
    
    func configureViewModel() {
        Task {
            await viewModel.getActorItems()
        }
       // viewModel.getActorList()
        viewModel.error = { errorMessage in
            print("Error: \(errorMessage)")
            self.refreshControl.endRefreshing()

        }
        viewModel.success = {
            self.collection.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

extension ActorController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLabelCell", for: indexPath) as! ImageLabelCell
        let actor = viewModel.items[indexPath.item]
        cell.configure(data: actor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 180, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
}
