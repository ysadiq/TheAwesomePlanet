//
//  AboutInfoViewModelTests.swift
//  TheAwesomePlanetTests
//
//  Created by Yahya Saddiq on 10/22/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//
import XCTest
@testable import TheAwesomePlanet

class AboutInfoViewModelTests: XCTestCase {
    var sut: AboutInfoViewModel!
    var closureExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        sut = AboutInfoViewModel()
    }

    override func tearDown() {
        sut = nil
        closureExpectation = nil
        super.tearDown()
    }

    func testFetchingAboutInfo() {
        closureExpectation = expectation(description: "Test Fetching AboutInfo")
        sut.fetchAboutInfo() { [weak self] (status, _) in
            guard let self = self,
                let aboutInfoCellViewModels = self.sut.cellViewModels as? [AboutInfoCellViewModel] else {
                return
            }
            if aboutInfoCellViewModels[0].field == "Backbase",
                aboutInfoCellViewModels[1].field == "Jacob Bontiusplaats 9",
                aboutInfoCellViewModels[2].field == "Amsterdam",
                aboutInfoCellViewModels[3].field == "1018 LL",
                aboutInfoCellViewModels[4].field == "This is the Backbase iOS assignment" {
                self.closureExpectation.fulfill()
            }
        }
        wait(for: [closureExpectation], timeout: 100)
    }
}
