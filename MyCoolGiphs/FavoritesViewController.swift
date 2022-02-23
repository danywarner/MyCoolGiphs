//
//  FavoritesViewController.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 23/02/22.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var favoritesCollectionView: UICollectionView!
    
    private var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadFavoriteGifs()
    }
    
    private func setupCollectionView() {
        favoritesCollectionView.register(UINib(nibName: "LargeGifCell", bundle: nil), forCellWithReuseIdentifier: "LargeGifCell")
        favoritesCollectionView.dataSource = self
//        favoritesCollectionView.delegate = self
    }
    
    private func loadFavoriteGifs() {
        viewModel.loadFavoriteGifs()
        favoritesCollectionView.reloadData()
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfFavoriteGifs
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeGifCell", for: indexPath) as? LargeGifCell else {
            return UICollectionViewCell()
        }
        let gifsArray = viewModel.getFavoriteGifsArray()
        let downsizedImage = gifsArray[indexPath.row].images.fixedHeightDownsampled
        cell.gifImageID = gifsArray[indexPath.row].id
        cell.isFavorite = gifsArray[indexPath.row].isFavorite
        cell.gifImageViewUrl = downsizedImage?.url
//        cell.delegate = viewModel
        
        return cell
    }
}
