//
//  MarvelResponseDTO.swift
//  openBank
//
//  Created by Cristobal Ramos on 2/3/22.
//
import Foundation

struct MarvelResponseDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClassDTO
}

struct DataClassDTO: Codable {
    let offset, limit, total, count: Int
    let results: [CharacterDTO]
}

struct CharacterDTO: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: String
    let thumbnail: ThumbnailDTO
    let resourceURI: String
    let comics, series: ComicsDTO
    let stories: StoriesDTO
    let events: ComicsDTO
    let urls: [URLElementDTO]

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

struct ComicsDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItemDTO]
    let returned: Int
}

struct ComicsItemDTO: Codable {
    let resourceURI: String
    let name: String
}

struct StoriesDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItemDTO]?
    let returned: Int
}

struct StoriesItemDTO: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

struct ThumbnailDTO: Codable {
    let path: String
    let thumbnailExtension: ExtensionDTO

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum ExtensionDTO: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}

struct URLElementDTO: Codable {
    let type: URLTypeDTO
    let url: String
}

enum URLTypeDTO: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
