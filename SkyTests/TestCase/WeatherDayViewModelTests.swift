//
//  WeatherDayViewModelTests.swift
//  SkyTests
//
//  Created by junyixin on 2018/5/28.
//  Copyright © 2018 junyixin. All rights reserved.
//

import XCTest
@testable import Sky

class WeatherDayViewModelTests: XCTestCase {
    
    var vm: WeatherDayViewModel!
    
    override func setUp() {
        super.setUp()
        
        let data = loadDataFromBundle(ofName: "DarkSky", ext: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let weatherData = try! decoder.decode(WeatherData.self, from: data)
        
        vm = WeatherDayViewModel(weatherData.daily.data[0])
    }
    
    override func tearDown() {
        super.tearDown()
        
        vm = nil
    }
    
    func test_date_display() {
        XCTAssertEqual(vm.date, "May 28")
    }
    
    func test_week_display() {
        XCTAssertEqual(vm.week, "Monday")
    }
}
