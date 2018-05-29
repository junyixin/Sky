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
    
    func test_weather_data_at_start_session() {
        manager?.weatherDataAt(latitude: 12.00, longitude: 29.18) { (_, _) in }
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
    
    func test_weather_data_at_gets_data() {
        let expect = expectation(description: "loading data from: \(API.authenticatedURL)")
        var data: WeatherData? = nil
        
        WeatherDataManager.shared.weatherDataAt(latitude: 52.0, longitude: 120.00, completion: { (response, error) in
            data = response
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func test_weather_data_at_failed_request() {
        session.responseError = NSError(domain: "invalid request", code: 100, userInfo: nil)
        
        var error: DataManagerError? = nil
        manager?.weatherDataAt(latitude: 52.0, longitude: 120.0, completion: { (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weather_data_at_response_status_code_not_equal_to_200() {
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let data = "{}".data(using: .utf8)!
        session.responseData = data
        
        var error: DataManagerError? = nil
        manager?.weatherDataAt(latitude: 52.00, longitude: 120.00, completion: { (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weather_data_at_handle_invalid_response() {
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = "{".data(using: .utf8)!
        session.responseData = data
        
        var error: DataManagerError? = nil
        manager?.weatherDataAt(latitude: 52.00, longitude: 120.00, completion: { (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.invalidResponse)
    }
    
    func test_weather_data_at_handler_response_decode() {
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = loadDataFromBundle(ofName: "DarkSky", ext: "json")
        session.responseData = data

        var decoded: WeatherData? = nil
        manager?.weatherDataAt(latitude: 100.00, longitude: 100.00, completion: { (d, _) in
            decoded = d
        })

        let expectWeekWeatherData = WeatherData.WeekWeatherData(
            data: [
                ForecastData(
                    time: Date(timeIntervalSince1970: 1527519757),
                    temperatureHigh: 82,
                    temperatureLow: 66,
                    icon: "clear-day",
                    humidity: 0.25)
            ])
        let expect = WeatherData(
            latitude: 100.0,
            longitude: 100.0,
            currently: WeatherData.CurrentWeather(
                time: Date(timeIntervalSince1970: 1527519757),
                summary: "Light Snow",
                icon: "snow",
                temperature: 23.0,
                humidity: 0.91
            ),
            daily: expectWeekWeatherData
        )

        XCTAssertEqual(decoded, expect)
    }
}
