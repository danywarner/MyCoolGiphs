//
//  GiphEntity.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 21/02/22.
//

import Foundation

struct GiphImage: Decodable {
    var width: String
    var height: String
    var url: String
}

struct GiphImageContainer: Decodable {
    var original: GiphImage?
    var downsized: GiphImage?
    var fixedHeightDownsampled: GiphImage?
    
    enum CodingKeys: String, CodingKey {
        case original
        case downsized
        case fixedHeightDownsampled = "fixed_height_downsampled"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        original = try container.decodeIfPresent(GiphImage.self, forKey: .original)
        downsized = try container.decodeIfPresent(GiphImage.self, forKey: .downsized)
        fixedHeightDownsampled = try container.decodeIfPresent(GiphImage.self, forKey: .fixedHeightDownsampled)
    }
}

struct GiphEntity: Decodable {
    var id: String
    var title: String
    var images: GiphImageContainer
}

struct GiphResponse: Decodable {
    var data: [GiphEntity]
}
