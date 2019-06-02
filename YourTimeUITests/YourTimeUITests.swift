//
//  YourTimeUITests.swift
//  YourTimeUITests
//
//  Created by Kensaku Tanaka on 2018/05/07.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import XCTest

class YourTimeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let manager = FileManager.default
        if let clockFilePath = manager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("clocks.txt") {
            try? manager.removeItem(at: clockFilePath)
        }
        UserDefaults.standard.set(0, forKey: "index")
        UserDefaults.standard.set(false, forKey: "blackBackground")
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQuestionButton() {
        let app = XCUIApplication()
        let questionButton = app.buttons["questionButton"]
        
        XCTAssert(questionButton.isHittable)
        XCTAssertFalse(app.buttons["closeButton"].exists)
        questionButton.tap()
        let closeButton = app.buttons["closeButton"]
        XCTAssert(closeButton.exists)
        
        closeButton.tap()
        XCTAssertFalse(app.buttons["closeButton"].exists)
    }
    
    func testExclamationButton() {
        let app = XCUIApplication()
        let exclamationButton = app.buttons["exclamationButton"]
        
        XCTAssert(exclamationButton.isHittable)
        exclamationButton.tap()
        XCTAssert(app.buttons["exclamationButton"].isHittable)
    }
    
    func testConfNameEqualNavigationBarTitle() {
        let app = XCUIApplication()
        let confButton = app.navigationBars.buttons["confButton"]
        XCTAssert(confButton.isHittable)
        
        confButton.tap()
        
        let nameTextField = app.textFields["nameTextField"]
        XCTAssert(nameTextField.isHittable)
        let name = nameTextField.value as! String
        let clockButton = app.navigationBars.buttons["clockButton"]
        XCTAssert(clockButton.isHittable)
        clockButton.tap()
        XCTAssert(app.navigationBars[name].exists)
    }
    
    func testIfConfNameChangedNavigationBarTitleChangeSame() {
        let app = XCUIApplication()
        app.navigationBars.buttons["confButton"].tap()
        let textField = app.textFields["nameTextField"]
        let name = textField.value as! String
        let changedName = changeString(str: name)
        textField.tap()
        textField.buttons["Clear text"].tap()
        textField.typeText(changedName)
        
        app.navigationBars.buttons["clockButton"].tap()
        XCTAssert(app.navigationBars[changedName].exists)
    }
    
    func changeString(str : String) -> String {
        if (str.count > 2) {
            return String(str.prefix(str.count-1))
        }
        return str + "1"
    }
}
