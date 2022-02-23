//
//  LargeGifCell.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 22/02/22.
//

protocol GifCellDelegate: AnyObject {
    func toggleFavorite(gifID: String)
}

import UIKit

final class LargeGifCell: UICollectionViewCell {

    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var gifImageView: UIImageView!
    
    weak var delegate: GifCellDelegate?
    
    var gifImageID: String?
    
    var isFavorite: Bool? {
        didSet {
            guard let isFavorite = isFavorite else {
                return
            }
            print("IDEEE: \(gifImageID) = \(String(isFavorite))")
            favoriteButton.backgroundColor = isFavorite ? .red : .yellow
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
        delegate?.toggleFavorite(gifID: gifImageID)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .yellow
    }
}
