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
}

class CharactersListPresenter {
    weak var view: CharactersListViewProtocol?
    
    init(with view: CharactersListViewProtocol) {
        self.view = view
    }
}

extension CharactersListPresenter: CharactersListPresenterProtocol {
    func loadCharacter(_ id: Int) {
        let request = CharacterRequest(id)
        request.fetchCharacter { error, characterList in
            if let _ = error {
                self.view?.showError()
            }
            if !characterList.isEmpty {
                self.view?.goToCharacterDetail(characterList[0])
            }
        }
    }
    
    func viewDidLoad() {
        self.loadCharacterList()
    }
}

private extension CharactersListPresenter {
    
    func loadCharacterList() {
        let request = CharactersListRequest()
        request.fetchCharactersList { error, characterList in
            if let _ = error {
                self.view?.showError()
            } else {
                self.view?.showCharacters(characterList)
            }
        }
    }
}
