//
//  GiphModelProtocol.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 24/02/22.
//

import Foundation

protocol GiphModelProtocol {
    var numberOfPopularGifs: Int { get }
    var numberOfFavoriteGifs: Int { get }
    
    func fetchPopularGifs(completion: @escaping () -> ())
    func searchGifs(with keyword: String, completion: @escaping () -> ())
    func getPopularGifsArray() -> [GiphEntity]
    func loadFavoriteGifs()
    func getFavoriteGifsArray() -> [GiphEntity]
    func toggleFavorite(gifID: String, completion: @escaping () -> ())
}
