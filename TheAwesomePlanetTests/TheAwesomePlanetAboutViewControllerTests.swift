//
//  TheAwesomePlanetAboutViewControllerTests.swift
//  TheAwesomePlanetTests
//
//  Created by Yahya Saddiq on 10/22/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import XCTest
@testable import TheAwesomePlanet

class TheAwesomePlanetAboutViewControllerTests: XCTestCase {
    var sut: TheAwesomePlanetAboutViewController!
    var mockDataProvider: MockDataProvider!
    var closureExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "TheAwesomePlanetAboutViewController") as? TheAwesomePlanetAboutViewController
        mockDataProvider = MockDataProvider()

        sut.viewModel = AboutInfoViewModel(dataManager: mockDataProvider)
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        mockDataProvider = nil
        super.tearDown()
    }

    func testInitViewModel() {
        sut.initViewModel()
        XCTAssertTrue(mockDataProvider.getAboutInfoIsCalled)
    }

}
