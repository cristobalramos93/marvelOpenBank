//
//  CharactersListPresenterMock.swift
//  openBankTests
//
//  Created by Cristobal Ramos on 17/7/22.
//

import Foundation
@testable import openBank

class CharactersListPresenterMock: CharactersListPresenterProtocol {
    
    weak var view: CharactersListViewProtocol?
    var api: MarvelApiRequestProtocol
    
    init(_ view: CharactersListViewProtocol, api: MarvelApiRequestProtocol) {
        self.view = view
        self.api = api
    }
    
    func loadCharacter(_ id: Int) {
        api.fetchCharacter(id: id) { error, character in
            guard let character = character else {
                self.view?.showError()
                return
            }
            self.view?.goToCharacterDetail(character)
        }
    }
    
    func viewDidLoad() {
        self.loadCharacterList()
    }
    
    func reloadCharacterList(offset: Int, characterList: [CharacterData], completion: @escaping () -> Void) {
        var list = characterList
        api.fetchCharactersList(offset: offset) { error, characterListPagination, total in
            if let _ = error {
                completion()
                self.view?.showError()
            } else {
                completion()
                list += characterListPagination
                self.view?.showCharacters(list)
            }
        }
    }
}

private extension CharactersListPresenterMock {
    func loadCharacterList() {
        api.fetchCharactersList(offset: 0) { error, characterList, total in
            if let _ = error, characterList.isEmpty {
                self.view?.showError()
            } else {
                self.view?.setTotalCharacters(total)
                self.view?.showCharacters(characterList)
            }
        }
    }
}
