//
//  CharacterDetailResponse.swift
//  openBank
//
//  Created by Cristobal Ramos on 3/3/22.
//

import Foundation

// MARK: - Welcome
struct MarvelCharacter: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClassCharacter
}

// MARK: - DataClass
struct DataClassCharacter: Codable {
    let offset, limit, total, count: Int
    let results: [Character]
}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: String
    let thumbnail: ThumbnailCharacter
    let resourceURI: String
    let comics, series: ComicsCharacter
    let stories: StoriesCharacter
    let events: ComicsCharacter
    let urls: [URLElementCharacter]

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
struct ComicsCharacter: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItemCharacter]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItemCharacter: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct StoriesCharacter: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItemCharacter]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItemCharacter: Codable {
    let resourceURI: String
    let name: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct ThumbnailCharacter: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElementCharacter: Codable {
    let type: String
    let url: String
}

