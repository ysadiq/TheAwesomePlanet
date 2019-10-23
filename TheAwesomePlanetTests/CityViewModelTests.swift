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
    var closureExpectation: XCTestExpectation!
    let numberOfCities = 5
    let expectationTimeout = 100.0

    override func setUp() {
        super.setUp()
        sut = CityViewModel()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        closureExpectation = nil
    }

    func testFilteringForA() {
        closureExpectation = expectation(description: "Search for A Completed")
        sut.fetchCities { [weak self] (status, _) in
            guard let self = self else {
                return
            }
            XCTAssertEqual(self.sut.numberOfCells, self.numberOfCities)
            self.sut.filter("A")
            XCTAssertEqual(self.sut.numberOfCells, 4)
            self.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }

    func testFilteringForAl() {
        closureExpectation = expectation(description: "Search for Al Completed")
        sut.fetchCities { [weak self] (status, _) in
            guard let self = self else {
                return
            }
            XCTAssertEqual(self.sut.numberOfCells, self.numberOfCities)
            self.sut.filter("Al")
            XCTAssertEqual(self.sut.numberOfCells, 2)
            self.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }

    func testFilteringForAlb() {
        closureExpectation = expectation(description: "Search for Alb Completed")
        sut.fetchCities { [weak self] (status, _) in
            guard let self = self else {
                return
            }
            XCTAssertEqual(self.sut.numberOfCells, self.numberOfCities)
            self.sut.filter("Alb")
            XCTAssertEqual(self.sut.numberOfCells, 1)
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
