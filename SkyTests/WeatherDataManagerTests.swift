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
    
    let session = MockURLSession()
    let dataTask = MockURLSessionDataTask()
    
    var manager: WeatherDataManager? = nil
    
    override func setUp() {
        super.setUp()
        
        session.sessionDataTask = dataTask
        manager = WeatherDataManager(baseURL: URL(string: "https://darksky.net")!, urlSession: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWeatherDataAtStartSession() {
        manager?.weatherDataAt(latitude: 12.00, longitude: 29.18) { (_, _) in }
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
    
    func testWeatherDataAtGetsData() {
        let expect = expectation(description: "loading data from: \(API.authenticatedURL)")
        var data: WeatherData? = nil
        
        WeatherDataManager.shared.weatherDataAt(latitude: 52.0, longitude: 120.00, completion: { (response, error) in
            data = response
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func testWeatherDataAtFailedRequest() {
        session.responseError = NSError(domain: "invalid request", code: 100, userInfo: nil)
        
        var error: DataManagerError? = nil
        manager?.weatherDataAt(latitude: 52.0, longitude: 120.0, completion: { (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func testWeatherDataAtResponseStatusCodeNotEqualTo200() {
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let data = "{}".data(using: .utf8)!
        session.responseData = data
        
        var error: DataManagerError? = nil
        manager?.weatherDataAt(latitude: 52.00, longitude: 120.00, completion: { (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func testWeatherDataAtHandleInvalidResponse() {
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = "{".data(using: .utf8)!
        session.responseData = data
        
        var error: DataManagerError? = nil
        manager?.weatherDataAt(latitude: 52.00, longitude: 120.00, completion: { (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.invalidResponse)
    }
    
    func testWeatherDataAtHandlerResponseDecode() {
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = """
        {
            "latitude": 52.0,
            "longitude": 100.0,
            "currently": {
                "temperature": 23.5,
                "humidity": 0.91,
                "icon": "snow",
                "time": 1507816281,
                "summary": "Clear"
            },
            daily: {
                "data": [
                    {
                        "time": 1507816281,
                        "temperatureHigh": 82,
                        "temperatureLow": 66,
                        "icon": "clear-day",
                        "humidity": 0.66
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        session.responseData = data
        
        var decoded: WeatherData? = nil        
        manager?.weatherDataAt(latitude: 52.00, longitude: 120.00, completion: { (d, _) in
            decoded = d
        })
        
        let expectWeekWeatherData = WeatherData.WeekWeatherData(
            data: [
                ForecastData(
                    time: Date(timeIntervalSince1970: 1507816281),
                    temperatureHigh: 82,
                    temperatureLow: 66,
                    icon: "clear-day",
                    humidity: 0.66)
            ])
        let expect = WeatherData(
            latitude: 52.0,
            longitude: 100.0,
            currently: WeatherData.CurrentWeather(
                time: Date(timeIntervalSince1970: 1507816281),
                summary: "Clear",
                icon: "snow",
                temperature: 23.5,
                humidity: 0.91
            ),
            daily: expectWeekWeatherData
        )
        
        XCTAssertEqual(decoded, expect)
    }
}
