//
//  ShapesAppUITests.swift
//  ShapesAppUITests
//
//  Created by Jimmy Wright on 7/28/25.
//

import XCTest

final class ShapesAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testToExerciseCodeCoverage() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // I created this test to try and execute as much code coverage as possible for the happy path
        // by pressing all the buttons.  Lets at least assert a circle got added to view hierarchy
        app.buttons["Circle"].tap()
        let circle = app.otherElements["circleView"]
        let circleExists = circle.waitForExistence(timeout: 2)
        XCTAssertTrue(circleExists, "Circle does not exist in view hierarchy")
        
        app.buttons["Square"].tap()
        app.buttons["Triangle"].tap()
        app.buttons["Edit Circles"].tap()
        app.buttons["Add"].tap()
        app.buttons["Remove"].tap()
        app.buttons["Delete All"].tap()
        app.buttons["Add"].tap()
        app.buttons["Back"].tap()
        app.buttons["Clear All"].tap()
        sleep(1)
    }
}
