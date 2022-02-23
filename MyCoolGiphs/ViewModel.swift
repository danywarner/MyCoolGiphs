//
//  ViewModel.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 21/02/22.
//

import Foundation

class ViewModel {
    var model = Model()
    
    var numberOfPopularGifs: Int {
        model.numberOfPopularGifs
    }
    
    var numberOfFavoriteGifs: Int {
        model.numberOfFavoriteGifs
    }
    
    func getPopularGifsArray() -> [GiphEntity] {
        model.getPopularGifsArray()
    }
    
    func fetchPopularGifs(completion: @escaping () -> ()) {
        model.fetchPopularGifs(completion: completion)
    }
    
    func searchGifs(with keyword: String, completion: @escaping () -> ()) {
        model.searchGifs(with: keyword, completion: completion)
    }
    
    func loadFavoriteGifs() {
        model.loadFavoriteGifs()
    }
    
    func getFavoriteGifsArray() -> [GiphEntity] {
        model.getFavoriteGifsArray()
    }
}

extension ViewModel: GifCellDelegate {
    func toggleFavorite(gifID: String) {
        model.toggleFavorite(gifID: gifID)
    }
}
