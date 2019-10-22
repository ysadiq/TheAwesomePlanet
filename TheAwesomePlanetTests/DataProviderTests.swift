//
//  DataProviderTests.swift
//  TheAwesomePlanetTests
//
//  Created by Yahya Saddiq on 10/22/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import XCTest
@testable import TheAwesomePlanet

class DataProviderTests: XCTestCase {
    var sut: DataProvider!
    var closureExpectation: XCTestExpectation!
    override func setUp() {
        super.setUp()
        sut = DataProvider()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetCities() {
        closureExpectation = expectation(description: "Get Cities Completed")
        sut.getCities { [weak self] (cities, _) in
            self?.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: 5)
        
    }

}
