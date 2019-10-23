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
    let expectationTimeout: TimeInterval = 100
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
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }

    func testGetAboutInfo() {
        closureExpectation = expectation(description: "Get AboutInfo Completed")
        sut.getAboutInfo { [weak self] (aboutInfos, _) in
            if aboutInfos?.companyName == "Backbase",
                aboutInfos?.companyAddress == "Jacob Bontiusplaats 9",
                aboutInfos?.city == "Amsterdam",
                aboutInfos?.postalCode == "1018 LL",
                aboutInfos?.details == "This is the Backbase iOS assignment" {
                self?.closureExpectation.fulfill()
            }
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }
}
