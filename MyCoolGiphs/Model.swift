//
//  Model.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 21/02/22.
//

import Alamofire

final class Model {
    
    private var storageManager = StorageManager()
    private var giphArray: [GiphEntity] = []
    private var favoritesGiphArray: [GiphEntity] = []
    
    var numberOfPopularGifs: Int {
        giphArray.count
    }
    
    var numberOfFavoriteGifs: Int {
        favoritesGiphArray.count
    }
    
    func getPopularGifsArray() -> [GiphEntity] {
        giphArray
    }
    
    func getFavoriteGifsArray() -> [GiphEntity] {
        favoritesGiphArray
    }
    
    func fetchPopularGifs(completion: @escaping () -> ()) {
        AF.request(
            "https://api.giphy.com/v1/gifs/trending",
            method: .get,
            parameters: ["api_key": "q6PzU6q7wODFyCS0EplZ0I5EVbDoXk45", "limit": 10]
        ).responseDecodable(of: GiphResponse.self) { response in
            if let response = response.value {
                self.giphArray = response.data
                completion()
            }
        }
    }
    
    func searchGifs(with keyword: String, completion: @escaping () -> ()) {
        AF.request(
            "https://api.giphy.com/v1/gifs/search",
            method: .get,
            parameters: ["api_key": "q6PzU6q7wODFyCS0EplZ0I5EVbDoXk45", "limit": 10, "q": keyword]
        ).responseDecodable(of: GiphResponse.self) { response in
            if let response = response.value {
                self.giphArray = response.data
                completion()
            }
        }
    }
    
    func loadFavoriteGifs() {
        favoritesGiphArray = storageManager.getFavoriteGifsFromStorage()
    }
    
}

extension Model {
    func toggleFavorite(gifID: String) {
        guard var gif = giphArray.first(where: { $0.id == gifID }) ?? favoritesGiphArray.first(where: { $0.id == gifID }) else {
            print("ERROR: gif id not found")
            return
        }
        gif.isFavorite.toggle()
        
        if gif.isFavorite {
            storageManager.writeToStorage(identifier: gif.id, object: gif)
        } else {
            storageManager.deleteFavoriteFromStorage(identifier: gif.id)
        }
    }
}
