//
//  LargeGifCell.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 22/02/22.
//

protocol GifCellDelegate: AnyObject {
    func toggleFavorite(gifID: String, completion: @escaping () -> ())
}

protocol GifCellReloadable: AnyObject {
    func reloadGifsCollectionView()
}

import UIKit

final class LargeGifCell: UICollectionViewCell {

    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var gifImageView: UIImageView!
    
    weak var delegate: GifCellDelegate?
    weak var reloadDelegate: GifCellReloadable?
    
    var gifImageID: String?
    
    var isFavorite: Bool? {
        didSet {
            guard let isFavorite = isFavorite,
                  let image: UIImage = isFavorite ? UIImage(named: "icons8-heart-30") : UIImage(named: "icons8-pixel-heart-30") else { return }
            favoriteButton.setImage(image, for: .normal)
        }
    }
    
    
    var gifImageViewUrl: String? {
        didSet {
            if let gifImageViewUrl = gifImageViewUrl, let url = URL(string: gifImageViewUrl), let data = try? Data(contentsOf: url) {
                gifImageView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction private func onFavoriteButtonTap() {
        guard let gifImageID = gifImageID else {
            return
        }
        isFavorite?.toggle()
        delegate?.toggleFavorite(gifID: gifImageID) { [weak self] in
            if !(self?.isFavorite ?? true) {
                self?.reloadDelegate?.reloadGifsCollectionView()
            }
        }
    }
}
