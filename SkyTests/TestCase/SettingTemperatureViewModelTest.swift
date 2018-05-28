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
    
    func testTemperatureDisplayInCelsiusMode() {
        let vm = SettingTemperatureViewModel(temperatureMode: .celsius)
        XCTAssertEqual(vm.labelText, "Celsius")
    }
    
    func testTemperatureDisplayInFahrenheitMode() {
        let vm = SettingTemperatureViewModel(temperatureMode: .fahrenheit)
        XCTAssertEqual(vm.labelText, "Fahrenheit")
    }
    
    func testTemperatureCelsiusModeSelected() {
        let temperatureMode: TemperatureMode = .celsius
        
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettingTemperatureViewModel(temperatureMode: temperatureMode)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.checkmark)
    }
    
    func testTemperatureCelsiusModeUnSelected() {
        let temperatureMode: TemperatureMode = .celsius
        
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettingTemperatureViewModel(temperatureMode: .fahrenheit)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.none)
    }
    
    func testTemperatureFahrenheitModeSelected() {
        let temperatureMode: TemperatureMode = .fahrenheit
        
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettingTemperatureViewModel(temperatureMode: temperatureMode)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.checkmark)
    }
    
    func testTemperatureFahrenheitModeUnSelected() {
        let temperatureMode: TemperatureMode = .fahrenheit
        
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettingTemperatureViewModel(temperatureMode: .celsius)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.none)
    }
}
