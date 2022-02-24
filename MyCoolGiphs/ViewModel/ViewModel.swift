//
//  ViewModel.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 21/02/22.
//

import Foundation

//NOTE: I could have used a different ViewModel for each ViewController, but for sake of time I'd rather create just one class, but this should not be done because the Single ViewModel could become giant
final class ViewModel {
    
    var model: GiphModelProtocol
    
    init(model: GiphModelProtocol) {
        self.model = model
    }
    
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
    func toggleFavorite(gifID: String, completion: @escaping () -> ()) {
        model.toggleFavorite(gifID: gifID, completion: completion)
    }
}
