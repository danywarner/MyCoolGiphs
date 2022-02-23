//
//  ViewModel.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 21/02/22.
//

import Foundation

class ViewModel {
    var model = Model()
    
    func getGifsArray() -> [GiphEntity] {
        model.getGifsArray()
    }
    
    func fetchPopularGifs(completion: @escaping () -> ()) {
        model.fetchPopularGifs(completion: completion)
    }
    
    func searchGifs(with keyword: String, completion: @escaping () -> ()) {
        model.searchGifs(with: keyword, completion: completion)
    }
}

extension ViewModel: GifCellDelegate {
    func toggleFavorite(gifID: String) {
        model.toggleFavorite(gifID: gifID)
    }
}
