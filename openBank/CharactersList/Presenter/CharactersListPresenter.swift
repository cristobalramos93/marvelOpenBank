//
//  CharactersListPresenter.swift
//  openBank
//
//  Created by Cristobal Ramos on 2/3/22.
//

import Foundation

protocol CharactersListPresenterProtocol: AnyObject {
    var view: CharactersListViewProtocol? { get set }
    func viewDidLoad()
    func loadCharacter(_ id: Int)
    func reloadCharacterList(offset: Int, characterList: [CharacterData], completion: @escaping () -> Void)
}

class CharactersListPresenter {
    weak var view: CharactersListViewProtocol?
    private var api: MarvelApiRequestProtocol
    
    init(_ view: CharactersListViewProtocol, api: MarvelApiRequestProtocol) {
        self.view = view
        self.api = api
    }
}

extension CharactersListPresenter: CharactersListPresenterProtocol {
    func loadCharacter(_ id: Int) {
        self.api.fetchCharacter(id: id) { error, character in
            guard let character = character else {
                DispatchQueue.main.async {
                    self.view?.showError()
                }
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
        self.api.fetchCharactersList(offset: offset) { error, characterListPagination, total in
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

private extension CharactersListPresenter {
    
    func loadCharacterList() {
        self.api.fetchCharactersList(offset: 0) { error, characterList, total in
            if let _ = error {
                self.view?.showError()
            } else {
                self.view?.setTotalCharacters(total)
                self.view?.showCharacters(characterList)
            }
        }
    }
}
