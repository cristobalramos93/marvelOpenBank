//
//  openBankTests.swift
//  openBankTests
//
//  Created by Cristobal Ramos on 6/3/22.
//

import XCTest
@testable import openBank

class openBankTests: XCTestCase {
    
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testExample() throws {}

    func testPerformanceExample() throws {
        measure {
        }
    }
    
    func testGetOneCharacter() throws {
        let expectation = XCTestExpectation(description: "Request of one character")
        CharacterRequest(1009144).fetchCharacter { error, data in
            XCTAssertNil(error)
            XCTAssertEqual(1, data.count)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetListCharacters() throws {
        let expectation = XCTestExpectation(description: "Request of the list of characters")
        CharactersListRequest().fetchCharactersList { error, data in
            XCTAssertNil(error)
            XCTAssertNotEqual(0, data.count)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
