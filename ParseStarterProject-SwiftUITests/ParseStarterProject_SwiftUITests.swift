//
//  ParseStarterProject_SwiftUITests.swift
//  ParseStarterProject-SwiftUITests
//
//  Created by Varun Babu on 6/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import XCTest
@testable import ParseStarterProject_Swift

class ParseStarterProject_SwiftUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
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
    
    func testloginButton() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()

        app.buttons["Login"].tap()
        app.alerts["Login Succesful"].buttons["OK"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(app.buttons["Login"].exists)
        
        
        
    }
    
    func testLoginSuccessful(){
        
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.tap()
        app.menuItems["Select All"].tap()
        app.menuItems["Cut"].tap()
        usernameTextField.typeText("varunbabu008")
        
        let passwordTextField = app.textFields["Password"]
        passwordTextField.tap()
        passwordTextField.tap()
        app.menuItems["Select All"].tap()
        app.menuItems["Cut"].tap()
        passwordTextField.typeText("varun")
        app.buttons["Login"].tap()
        XCTAssert(app.alerts.element.staticTexts["Login Succesful"].exists)
        //app.alerts["Login Succesful"].buttons["OK"].tap()
        
        
        
    }
    
    func testLoginFailed(){
        
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("1")
        app.buttons["Login"].tap()
        XCTAssert(app.alerts.element.staticTexts["Login  failed"].exists)
        //app.alerts["Login  failed"].buttons["OK"].tap()
        
    }
    
    func testSignUpFailed(){
        
        let app = XCUIApplication()
        app.buttons["Sign Up"].tap()
        XCTAssert(app.alerts.element.staticTexts["Sign Up Failed"].exists)
        app.alerts["Sign Up Failed"].buttons["OK"].tap()
        
        
    }
    
    
    
    
    
    
    
}
