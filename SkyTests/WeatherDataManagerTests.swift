//
//  WeatherDataManagerTests.swift
//  SkyTests
//
//  Created by junyixin on 19/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import XCTest

@testable import Sky

class WeatherDataManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWeatherDataAtStartSession() {
        let session = MockURLSession()
        let dataTask = MockURLSessionDataTask()
        
        session.sessionDataTask = dataTask
        
        let manager = WeatherDataManager(baseURL: URL(string: "https://darksky.net")!, urlSession: session)
        manager.weatherDataAt(latitude: 12.00, longitude: 29.18) { (_, _) in }
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
}
