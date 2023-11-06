//
//  VideoAppUITests.swift
//  VideoAppUITests
//
//  Created by Victoria Galikova on 02/11/2023.
//

import XCTest

final class VideoAppUITests: XCTestCase {

    func testMainScreen() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.staticTexts["Videá"].exists)
        XCTAssertTrue(app.otherElements.containing(.any, identifier: "list").element.exists)
        XCTAssertTrue(app.otherElements.containing(.any, identifier: "sipka").element.exists)
        XCTAssertTrue(app.otherElements.containing(.any, identifier: "nazov").element.exists)
        XCTAssertTrue(app.otherElements.containing(.any, identifier: "obrazok").element.exists)
    }
    
    func testFromMainToDetail() {
        
        let app = XCUIApplication()
        app.launch()
        let firstCell = app.cells.element(boundBy: 0)
        let firstCellName = firstCell.staticTexts.element.label
        firstCell.tap()
        let nameLabelText = app.staticTexts["name"].label
    
        XCTAssertEqual(nameLabelText, firstCellName)
    }
    
    func testDetailsScreen() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.staticTexts["name"].exists)
        XCTAssertTrue(app.staticTexts["description"].exists)
        XCTAssertTrue(app.buttons["next"].exists)
        XCTAssertTrue(app.buttons["Downloaded"].exists || app.buttons["Download"].exists)
        XCTAssertTrue(app.buttons["Back"].exists)
    }
    
}
