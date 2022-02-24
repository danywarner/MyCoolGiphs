//
//  MyCoolGiphsTests.swift
//  MyCoolGiphsTests
//
//  Created by daniel.warner on 21/02/22.
//

import XCTest
@testable import MyCoolGiphs

class MyCoolGiphsTests: XCTestCase {

    var viewModel: ViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = ViewModel(model: ModelStub())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testMapPopularGifs() {
        viewModel.fetchPopularGifs { }
        XCTAssert(self.viewModel.numberOfPopularGifs == 5)
    }
    
    func testMapSearchedGifs() {
        viewModel.searchGifs(with: "any keyword") { }
        XCTAssert(self.viewModel.numberOfPopularGifs == 3)
    }
    
    func testMarkFavorite() {
        viewModel.fetchPopularGifs { }
        viewModel.toggleFavorite(gifID: "m2fQwSWHsfl26rnSDB") { }
        let favoriteGifs = viewModel.getFavoriteGifsArray()
        XCTAssert(favoriteGifs.count == 1)
        XCTAssert(favoriteGifs.contains { $0.id == "m2fQwSWHsfl26rnSDB"})
    }
    
    func testUnMarkFavorite() {
        viewModel.fetchPopularGifs { }
        viewModel.toggleFavorite(gifID: "m2fQwSWHsfl26rnSDB") { }
        viewModel.toggleFavorite(gifID: "m2fQwSWHsfl26rnSDB") { }
        let favoriteGifs = viewModel.getFavoriteGifsArray()
        XCTAssert(favoriteGifs.isEmpty)
    }
}
