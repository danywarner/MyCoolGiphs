//
//  LargeGifCell.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 22/02/22.
//

import UIKit

final class LargeGifCell: UICollectionViewCell {

    @IBOutlet private weak var gifImageView: UIImageView!
    var gifImageViewUrl: String? {
        didSet {
            if let gifImageViewUrl = gifImageViewUrl, let url = URL(string: gifImageViewUrl), let data = try? Data(contentsOf: url) {
                gifImageView.image = UIImage(data: data)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .yellow
        
        
    }

}
