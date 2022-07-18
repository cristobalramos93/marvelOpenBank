//
//  TestCharactersListViewController.swift
//  openBankTests
//
//  Created by Cristobal Ramos on 17/7/22.
//

import XCTest
@testable import openBank

class TestCharactersListViewController: XCTestCase {
    
    var presenter: CharactersListPresenterProtocol!
    var charactersListViewController =  CharactersListViewController()
    var api: ApiMock!
    
    override func setUp() {
        super.setUp()
        self.api = ApiMock(json: "CharacterList")
        self.charactersListViewController.loadView()
    }
    
    func test_Given_list_of_characters_When_JSON_is_loaded_Then_view_show_table_view_with_elements() throws {
        self.presenter = CharactersListPresenterMock(charactersListViewController, api: api)
        self.charactersListViewController.presenter = self.presenter
        self.charactersListViewController.viewDidLoad()
        XCTAssertTrue(self.charactersListViewController.errorView.isHidden)
        XCTAssertFalse(self.charactersListViewController.tableView.isHidden)
        XCTAssertFalse(self.charactersListViewController.charactersList.isEmpty)
    }
    
    func test_Given_empty_list_of_characters_When_JSON_is_loaded_Then_view_show_error_view() throws {
        self.presenter = CharactersListPresenterMock(charactersListViewController, api: ApiMock(json: "Empty"))
        self.charactersListViewController.presenter = self.presenter
        self.charactersListViewController.viewDidLoad()
        XCTAssertFalse(self.charactersListViewController.errorView.isHidden)
        XCTAssertTrue(self.charactersListViewController.tableView.isHidden)
        XCTAssertTrue(self.charactersListViewController.charactersList.isEmpty)
    }
}
