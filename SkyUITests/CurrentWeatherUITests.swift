//
//  CurrentWeatherUITests.swift
//  SkyUITests
//
//  Created by junyixin on 26/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import XCTest

class CurrentWeatherUITests: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app.launchArguments += ["UI-TESTING"]
        app.launchEnvironment["SkyJSON"] = """
            {
            "latitude": 52.0,
            "longitude": 100.0,
            "currently": {
                "temperature": 23.5,
                "humidity": 0.91,
                "icon": "snow",
                "time": 1507816281,
                "summary": "Clear"
                }
            }
        """
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLocationButtonExists() {
        let locationBtn = app.buttons["locationBtn"]
        
        XCTAssert(locationBtn.exists)
    }
    
    
}
