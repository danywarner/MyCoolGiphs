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
    
    private lazy var listCVLayout: UICollectionViewFlowLayout = {

        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        collectionFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
        collectionFlowLayout.minimumInteritemSpacing = 20
        collectionFlowLayout.minimumLineSpacing = 20
        collectionFlowLayout.scrollDirection = .vertical
        return collectionFlowLayout
    }()

    private lazy var gridCVLayout: UICollectionViewFlowLayout = {
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        collectionFlowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 80) / 2 , height: UIScreen.main.bounds.height * 0.16)
        collectionFlowLayout.minimumInteritemSpacing = 20
        collectionFlowLayout.minimumLineSpacing = 20
        return collectionFlowLayout
    }()
    
    private var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadFavoriteGifs()
    }
    
    @IBAction func onSegmentedControlSwitch(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            favoritesCollectionView.startInteractiveTransition(to: gridCVLayout, completion: nil)
            favoritesCollectionView.finishInteractiveTransition()
        } else {
            favoritesCollectionView.startInteractiveTransition(to: self.listCVLayout, completion: nil)
            favoritesCollectionView.finishInteractiveTransition()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteGifs()
    }
    
    private func setupCollectionView() {
        favoritesCollectionView.register(UINib(nibName: "LargeGifCell", bundle: nil), forCellWithReuseIdentifier: "LargeGifCell")
        favoritesCollectionView.dataSource = self
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
        cell.delegate = viewModel
        cell.reloadDelegate = self
        
        return cell
    }
}

extension FavoritesViewController: GifCellReloadable {
    func reloadGifsCollectionView() {
        favoritesCollectionView.reloadData()
    }
}
