//
//  TestCharacterDetailViewController.swift
//  openBankTests
//
//  Created by Cristobal Ramos on 18/7/22.
//

import XCTest
@testable import openBank

class TestCharacterDetailViewController: XCTestCase {
    
    var presenter: CharactersListPresenterProtocol!
    var characterDetailViewController =  CharacterDetailViewController()
    var api: ApiMock!
    
    override func setUp() {
        super.setUp()
        self.api = ApiMock(json: "CharacterList")
        characterDetailViewController.loadView()
    }
    
    func test_Given_one_character_When_JSON_is_mocked_and_dont_have_description_Then_stackView_have_5_elements() throws {
        api.fetchCharacter(id: 0) { error, character in
            guard let character = character else { return }
            self.characterDetailViewController.setupView(character)
            let subViews = self.characterDetailViewController.stackView.subviews.count
            XCTAssertTrue(subViews == 5)
        }
    }
    
    func test_Given_one_character_When_JSON_is_mocked_and_have_description_Then_stackView_have_6_elements() throws {
        ApiMock(json: "CharacterDescription").fetchCharacter(id: 0) { error, character in
            guard let character = character else { return }
            self.characterDetailViewController.setupView(character)
            let subViews = self.characterDetailViewController.stackView.subviews.count
            XCTAssertTrue(subViews == 6)
        }
    }
}
