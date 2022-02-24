//
//  GiphEntity.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 21/02/22.
//

import Foundation

//NOTE: I should create a single file for each entity, but for sake of time, I put them all in this same file

struct GiphImage: Codable {
    var width: String
    var height: String
    var url: String
}

struct GiphImageContainer: Codable {
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

class GiphEntity: Codable {
    var id: String
    var title: String
    var images: GiphImageContainer
    var isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case images
        case isFavorite
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        images = try container.decode(GiphImageContainer.self, forKey: .images)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }
}

struct GiphResponse: Codable {
    var data: [GiphEntity]
}
