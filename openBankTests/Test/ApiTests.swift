//
//  ApiTests.swift
//  openBankTests
//
//  Created by Cristobal Ramos on 6/3/22.
//

import XCTest
@testable import openBank

class ApiTests: XCTestCase {
    
    var api: MarvelApiRequest!
    
    override func setUp() {
        super.setUp()
        self.api = MarvelApiRequest()
    }
    
    func testGetListCharacters() throws {
        let expectation = XCTestExpectation(description: "Request of the list of characters")
        api.fetchCharactersList(offset: 0) { error, characterList, total in
            XCTAssertNil(error)
            XCTAssertNotEqual(0, characterList.count)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
