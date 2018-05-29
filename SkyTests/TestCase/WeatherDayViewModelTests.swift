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
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureMode)
    }
    
    func test_date_display() {
        XCTAssertEqual(vm.date, "May 28")
    }
    
    func test_week_display() {
        XCTAssertEqual(vm.week, "Monday")
    }
    
    func test_humidity_display() {
        XCTAssertEqual(vm.humidity, "25 %")
    }
    
    func test_temperature_display_in_celsius() {
        UserDefaults.standard.set(TemperatureMode.celsius.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        XCTAssertEqual(vm.temperature, "18.9 ℃ ~ 27.8 ℃")
    }
    
    func test_temperature_display_in_fahrenheit() {
        UserDefaults.standard.set(TemperatureMode.fahrenheit.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        XCTAssertEqual(vm.temperature, "66.0 ℉ ~ 82.0 ℉")
    }
    
    func test_weather_icon_display() {
        let iconFromViewModel = UIImagePNGRepresentation(vm.weatherIcon!)!
        let iconFromTestData = UIImagePNGRepresentation(UIImage(named: "clear-day")!)!
        
        XCTAssertEqual(vm.weatherIcon?.size.width, 108.0)
        XCTAssertEqual(vm.weatherIcon?.size.height, 108.0)
        XCTAssertEqual(iconFromViewModel, iconFromTestData)
    }
}
