//
//  CharacyerRequest.swift
//  openBank
//
//  Created by Cristobal Ramos on 4/3/22.
//

import Foundation

class CharacterRequest {
    let api: API
    let publicKey = "c334b4d15b9c3a97c35dd8d147d73979"
    let privateKey = "a4a20f628100dfefe68234ce7824cfc8dbf62261"
    
    init(_ id: Int) {
        let ts = String(Date().currentTimeMillis())
        let union = ts + privateKey + publicKey
        let md5 = union.md5()
        var urlComponents = URLComponents()
        let queryTs = URLQueryItem(name: "ts", value: ts)
        let queryKey = URLQueryItem(name: "apikey", value: publicKey)
        let queryMd5 = URLQueryItem(name: "hash", value: md5)
        urlComponents.scheme = "https"
        urlComponents.host = "gateway.marvel.com"
        urlComponents.path = "/v1/public/characters/\(id)"
        urlComponents.queryItems = [queryTs, queryKey, queryMd5]
        self.api = API(url: urlComponents.url ?? URL(fileURLWithPath: ""))
    }
    
    func fetchCharacter(_ completion: @escaping (Error?, [Character]) -> Void) {
        var charactersList: [Character] = []
        api.performRequest { data, response, error in
            guard let data = data else { return completion(error, [])}
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MarvelCharacter.self, from: data)
                charactersList = response.data.results.sorted(by: {$0.name < $1.name })
            } catch let err {
                completion(err, [])
            }
            DispatchQueue.main.async {
                completion(nil, charactersList)
            }
        }
    }
}
