//
//  ApiMock.swift
//  openBankTests
//
//  Created by Cristobal Ramos on 17/7/22.
//

import Foundation
@testable import openBank

enum MyError: Error {
    case runtimeError
}

class ApiMock: MarvelApiRequestProtocol {

    private var json: String
    
    init(json: String) {
        self.json = json
    }
    
    func fetchCharactersList(offset: Int, _ completion: @escaping (Error?, [CharacterData], Int) -> Void) {
        var charactersList: [CharacterData] = []
        let decoder = JSONDecoder()
        let testBundle = Bundle(for: type(of: self))
        if let fileURL = testBundle.url(forResource: json, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                if let response = try? decoder.decode(MarvelResponseDTO.self, from: data) {
                    let total = response.data.total
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
                    completion(nil, charactersList, total)
                } else {
                    completion(nil, [], 0)
                }
            } catch {
                completion(error, [], 0)
            }
        } else {
            completion(MyError.runtimeError, [], 0)
        }
    }
    
    func fetchCharacter(id: Int, _ completion: @escaping (Error?, CharacterData?) -> Void) {
        var character: CharacterData?
        let decoder = JSONDecoder()
        let testBundle = Bundle(for: type(of: self))
        if let fileURL = testBundle.url(forResource: json, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                if let response = try? decoder.decode(MarvelResponseDTO.self, from: data) {
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
                    completion(nil, character)
                } else {
                    completion(nil, nil)
                }
            } catch {
                completion(error, nil)
            }
        } else {
            completion(MyError.runtimeError, nil)
        }
    }
}
