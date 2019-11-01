//
//  TheAwesomePlanetUITests.swift
//  TheAwesomePlanetUITests
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import XCTest
@testable import TheAwesomePlanet

class TheAwesomePlanetUITests: XCTestCase {
    var app: XCUIApplication!
    var closureExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        // Since UI tests are more expensive to run, it's usually a good idea
        // to exit if a failure was encountered
        continueAfterFailure = false
        app = XCUIApplication()

        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testAlabamaCell() {
        let alabamaCell = XCUIApplication()
            .tables
            .cells
            .staticTexts["Alabama, US"]

        XCTAssertTrue(alabamaCell.exists)
    }

    func testNavigatingToMapView() {
        guard app.isPortraitView else {
            return
        }
        XCUIApplication()
            .tables
            .cells
            .element(boundBy: 0)
            .tap()

        XCTAssertTrue(app.isMapView)
    }

    /*func testNavigatingToAboutView() {
        XCUIApplication()
            .tables
            .cells
            .element(boundBy: 0)
            .buttons["AboutInfoButton"]
            .tap()

        XCTAssertTrue(app.isAboutInfoView)
    }

    func testAboutViewContent() {
        XCUIApplication()
            .tables
            .cells
            .element(boundBy: 0)
            .buttons["AboutInfoButton"]
            .tap()
        
        XCTAssertTrue(XCUIApplication().tables.cells.staticTexts["Backbase"].exists)
        XCTAssertTrue(XCUIApplication().tables.cells.staticTexts["Jacob Bontiusplaats 9"].exists)
        XCTAssertTrue(XCUIApplication().tables.cells.staticTexts["1018 LL"].exists)
        XCTAssertTrue(XCUIApplication().tables.cells.staticTexts["Amsterdam"].exists)
        XCTAssertTrue(XCUIApplication().tables.cells.staticTexts["This is the Backbase iOS assignment"].exists)
    }*/

}

extension XCUIApplication {
    var isPortraitView: Bool {
        return otherElements["PortraitView"].exists
    }

    var isMapView: Bool {
        return otherElements["MapView"].exists
    }

    var isAboutInfoView: Bool {
        return otherElements["AboutInfoView"].exists
    }
}
