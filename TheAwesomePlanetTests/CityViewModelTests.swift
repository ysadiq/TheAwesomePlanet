//
//  CityViewModelTests.swift
//  TheAwesomePlanetTests
//
//  Created by Yahya Saddiq on 10/22/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import XCTest
@testable import TheAwesomePlanet

class CityViewModelTests: XCTestCase {
    var sut: CityViewModel!
    var mockDataProvider: MockDataProvider!
    var closureExpectation: XCTestExpectation!
    let numberOfCities = 209557
    let expectationTimeout = 100.0

    override func setUp() {
        super.setUp()
        mockDataProvider = MockDataProvider()
        sut = CityViewModel()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        closureExpectation = nil
    }

    func testFilteringCairo() {
        closureExpectation = expectation(description: "Search for Cairo Completed")
        sut.fetchCities { [weak self] (status, _) in
            guard let self = self else {
                return
            }
            XCTAssertEqual(self.sut.numberOfCells, self.numberOfCities)
            self.sut.filter("Cairo")
            XCTAssertEqual(self.sut.numberOfCells, 10)
            self.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }

    func testFilteringAmsterdam() {
        closureExpectation = expectation(description: "Search for Amsterdam Completed")
        sut.fetchCities { [weak self] (status, _) in
            guard let self = self else {
                return
            }
            XCTAssertEqual(self.sut.numberOfCells, self.numberOfCities)
            self.sut.filter("Amsterdam")
            XCTAssertEqual(self.sut.numberOfCells, 4)
            self.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }

    func testFilteringInvalidCity() {
        closureExpectation = expectation(description: "Search for Invalid Completed")
        sut.fetchCities { [weak self] (status, _) in
            guard let self = self else {
                return
            }
            XCTAssertEqual(self.sut.numberOfCells, self.numberOfCities)
            self.sut.filter("invalid city")
            XCTAssertEqual(self.sut.numberOfCells, 0)
            self.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }

}
