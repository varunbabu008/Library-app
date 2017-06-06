//
//  ParseStarterProject_SwiftTests.swift
//  ParseStarterProject-SwiftTests
//
//  Created by Varun Babu on 3/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import XCTest
@testable import ParseStarterProject_Swift
@testable import Pods_ParseStarterProject_Swift

class ParseStarterProject_SwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce

    }
    
    func uiTesting(){
        
        let app = XCUIApplication()
        let typeSomethingTextField = app.textFields["userNameTextField"]
        typeSomethingTextField.tap()
        typeSomethingTextField.typeText("varun")
        XCTAssert(typeSomethingTextField.exists)
        
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func teststripeAmount(){
        
        var helloworld:String?
        XCTAssertNil(helloworld)
        
        helloworld = "Hello"
        
        XCTAssertEqual(helloworld, "Hello")
        
        
    }
    
    func diffDate(){
        
        var startDate:Date = Date()
        var endDate:Date = Date()
        
        
        
        
    }
    
    
}
