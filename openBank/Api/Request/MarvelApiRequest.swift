//
//  MarvelApiRequest.swift
//  openBank
//
//  Created by Cristobal Ramos on 2/3/22.
//

import Foundation

protocol MarvelApiRequestProtocol {
    func fetchCharactersList(offset: Int, _ completion: @escaping (Error?, [CharacterData], Int) -> Void)
    func fetchCharacter(id: Int, _ completion: @escaping (Error?, CharacterData?) -> Void)
}

class MarvelApiRequest: MarvelApiRequestProtocol {
    var api: API?
    let limit: URLQueryItem
    let queryTs: URLQueryItem
    let queryKey: URLQueryItem
    let queryMd5: URLQueryItem
    var urlComponents = URLComponents()
    let publicKey = "c334b4d15b9c3a97c35dd8d147d73979"
    let privateKey = "a4a20f628100dfefe68234ce7824cfc8dbf62261"
    
    init() {
        let ts = String(Date().currentTimeMillis())
        let union = ts + privateKey + publicKey
        let md5 = union.md5()
        self.queryTs = URLQueryItem(name: "ts", value: ts)
        self.queryKey = URLQueryItem(name: "apikey", value: publicKey)
        self.queryMd5 = URLQueryItem(name: "hash", value: md5)
        self.limit = URLQueryItem(name: "limit", value: "10")
        self.urlComponents.scheme = "https"
        self.urlComponents.host = "gateway.marvel.com"
    }
    
    func fetchCharactersList(offset: Int, _ completion: @escaping (Error?, [CharacterData], Int) -> Void) {
        let offsetQuery = URLQueryItem(name: "offset", value: String(offset))
        self.urlComponents.path = "/v1/public/characters"
        self.urlComponents.queryItems = [offsetQuery, self.limit, self.queryTs, self.queryKey, self.queryMd5]
        self.api = API(url: self.urlComponents.url ?? URL(fileURLWithPath: ""))
        var charactersList: [CharacterData] = []
        var total = 0
        guard let api = self.api else { return completion(nil, [], total) }
        api.performRequest { data, response, error in
            guard let data = data else { return completion(error, [], total) }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MarvelResponseDTO.self, from: data)
                charactersList = response.data.results.map {
                    let imageUrl = $0.thumbnail.path + "." + $0.thumbnail.thumbnailExtension.rawValue
                    return CharacterData(id: $0.id,
                                  name: $0.name,
                                  description: $0.resultDescription,
                                  imageUrl: imageUrl,
                                  comics: $0.comics.available,
                                  series: $0.series.available,
                                  stories:$0.stories.available,
                                  events: $0.events.available)
                }
                total = response.data.total
            } catch let err {
                completion(err,[], total)
            }
            DispatchQueue.main.async {
                completion(nil, charactersList, total)
            }
        }
    }
    
    func fetchCharacter(id: Int, _ completion: @escaping (Error?, CharacterData?) -> Void) {
        var character: CharacterData?
        self.urlComponents.path = "/v1/public/characters/\(id)"
        self.api = API(url: self.urlComponents.url ?? URL(fileURLWithPath: ""))
        guard let api = self.api else { return completion(nil, nil) }
        api.performRequest { data, response, error in
            guard let data = data else { return completion(error, nil)}
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MarvelResponseDTO.self, from: data)
                let characterDto = response.data.results.first
                let imageUrl = (characterDto?.thumbnail.path ?? "") + "." + (characterDto?.thumbnail.thumbnailExtension.rawValue ?? "")
                character = CharacterData(id: characterDto?.id ?? 0,
                                                  name: characterDto?.name ?? "",
                                                  description: characterDto?.resultDescription,
                                                  imageUrl: imageUrl,
                                                  comics: characterDto?.comics.available,
                                                  series: characterDto?.series.available,
                                                  stories:characterDto?.stories.available,
                                                  events: characterDto?.events.available)
            } catch let err {
                completion(err, character)
            }
            DispatchQueue.main.async {
                completion(nil, character)
            }
        }
    }
}
