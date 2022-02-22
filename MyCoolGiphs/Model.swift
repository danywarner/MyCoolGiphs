//
//  Model.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 21/02/22.
//

import Alamofire

final class Model {
    
    func getGifsArray() -> [GiphEntity] {
        giphArray
    }
    
    private var giphArray: [GiphEntity] = []
    
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
    
}
