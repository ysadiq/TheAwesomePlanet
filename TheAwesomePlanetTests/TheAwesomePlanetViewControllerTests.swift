//
//  TheAwesomePlanetViewControllerTests.swift
//  TheAwesomePlanetTests
//
//  Created by Yahya Saddiq on 10/21/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import XCTest
@testable import TheAwesomePlanet

class TheAwesomePlanetViewControllerTests: XCTestCase {
    var sut: TheAwesomePlanetViewController!
    var mockDataProvider: MockDataProvider!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "TheAwesomePlanetViewController") as? TheAwesomePlanetViewController
        mockDataProvider = MockDataProvider()

        sut.viewModel = CityViewModel(dataManager: mockDataProvider)
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        mockDataProvider = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        XCTAssertTrue(mockDataProvider.getCitiesIsCalled)
    }

}
