//
//  ModelStub.swift
//  MyCoolGiphsTests
//
//  Created by daniel.warner on 24/02/22.
//

import Foundation
@testable import MyCoolGiphs

class ModelStub: GiphModelProtocol {
    
    private var mockedPopularGifs: [GiphEntity] = []
    private var mockedFavoriteGifs: [GiphEntity] = []
    
    var numberOfPopularGifs: Int {
        mockedPopularGifs.count
    }
    
    var numberOfFavoriteGifs: Int {
        mockedFavoriteGifs.count
    }
    
    func fetchPopularGifs(completion: @escaping () -> ()) {
        guard let popularGifsData = readDictionaryJson(fileName: "popularGifs") else { return }
        
        do {
            let giphResponse = try JSONDecoder().decode(GiphResponse.self, from: popularGifsData)
            mockedPopularGifs = giphResponse.data
        } catch {
            print("error reading JSON file popularGifs")
        }
    }
    
    func searchGifs(with keyword: String, completion: @escaping () -> ()) {
        guard let searchedGifsData = readDictionaryJson(fileName: "searchedGifs") else { return }
        
        do {
            let giphResponse = try JSONDecoder().decode(GiphResponse.self, from: searchedGifsData)
            mockedPopularGifs = giphResponse.data
        } catch {
            print("error reading JSON file popularGifs")
        }
    }
    
    func getPopularGifsArray() -> [GiphEntity] {
        return mockedPopularGifs
    }
    
    func loadFavoriteGifs() {
        // empty on purpose: I don't want to mess with the local storage from the tests suite for now
    }
    
    func getFavoriteGifsArray() -> [GiphEntity] {
        return mockedFavoriteGifs
    }
    
    func toggleFavorite(gifID: String, completion: @escaping () -> ()) {
        guard let gif = mockedPopularGifs.first(where: { $0.id == gifID }) ?? mockedFavoriteGifs.first(where: { $0.id == gifID }) else {
            print("ERROR: gif id not found")
            return
        }
        gif.isFavorite.toggle()
        
        if gif.isFavorite {
            mockedFavoriteGifs.append(gif)
        } else {
            mockedFavoriteGifs.removeAll { $0.id == gif.id }
        }
    }
}

extension ModelStub {
    private func readDictionaryJson(fileName: String) -> Data? {
        do {
            if let file = Bundle(for: MyCoolGiphsTests.self).url(forResource: fileName, withExtension: "json") {
                return try Data(contentsOf: file)
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
