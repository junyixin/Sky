//
//  SettingTemperatureViewModelTest.swift
//  SkyTests
//
//  Created by junyixin on 2018/5/28.
//  Copyright © 2018 junyixin. All rights reserved.
//

import XCTest
@testable import Sky

class SettingTemperatureViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureMode)
    }
    
    func test_temperature_display_in_celsius_mode() {
        let vm = SettingTemperatureViewModel(temperatureMode: .celsius)
        XCTAssertEqual(vm.labelText, "Celsius")
    }
    
    func test_temperature_display_in_fahrenheit_mode() {
        let vm = SettingTemperatureViewModel(temperatureMode: .fahrenheit)
        XCTAssertEqual(vm.labelText, "Fahrenheit")
    }
    
    func test_temperature_celsius_mode_selected() {
        let temperatureMode: TemperatureMode = .celsius
        
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettingTemperatureViewModel(temperatureMode: temperatureMode)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.checkmark)
    }
    
    func test_temperature_celsius_mode_unselected() {
        let temperatureMode: TemperatureMode = .celsius
        
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettingTemperatureViewModel(temperatureMode: .fahrenheit)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.none)
    }
    
    func test_temperature_fahrenheit_mode_selected() {
        let temperatureMode: TemperatureMode = .fahrenheit
        
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettingTemperatureViewModel(temperatureMode: temperatureMode)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.checkmark)
    }
    
    func test_temperature_fahrenheit_mode_unselected() {
        let temperatureMode: TemperatureMode = .fahrenheit
        
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettingTemperatureViewModel(temperatureMode: .celsius)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.none)
    }
}
