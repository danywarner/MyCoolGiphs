//
//  ViewController.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 21/02/22.
//

import UIKit

final class PopularViewController: UIViewController {

    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var gifsCollectionView: UICollectionView!
    
    private var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupCollectionView()
        fetchInitialGifs()
    }
    
    private func setupTextField() {
        searchTextField.delegate = self
    }
    
    private func fetchInitialGifs() {
        viewModel.fetchPopularGifs() { [weak self] in
            self?.gifsCollectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        gifsCollectionView.register(UINib(nibName: "LargeGifCell", bundle: nil), forCellWithReuseIdentifier: "LargeGifCell")
        gifsCollectionView.dataSource = self
        gifsCollectionView.delegate = self
        collectionViewFlowLayout.itemSize = CGSize(width: 300, height: 80)
    }
}

extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfPopularGifs
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeGifCell", for: indexPath) as? LargeGifCell else {
            return UICollectionViewCell()
        }
        let gifsArray = viewModel.getPopularGifsArray()
        let downsizedImage = gifsArray[indexPath.row].images.fixedHeightDownsampled
        cell.gifImageID = gifsArray[indexPath.row].id
        cell.isFavorite = gifsArray[indexPath.row].isFavorite
        cell.gifImageViewUrl = downsizedImage?.url
        cell.delegate = viewModel
        
        return cell
    }
}

extension PopularViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height: CGFloat = 80
        return CGSize(width: width, height: height)
    }
}

extension PopularViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let keyword = textField.text else { return true }
        viewModel.searchGifs(with: keyword) { [weak self] in
            self?.gifsCollectionView.reloadData()
            
        }
        textField.resignFirstResponder()
        return true
    }
}
