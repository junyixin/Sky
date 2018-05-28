//
//  SettingDateViewModelTests.swift
//  SkyTests
//
//  Created by junyixin on 2018/5/28.
//  Copyright © 2018 junyixin. All rights reserved.
//

import XCTest
@testable import Sky

class SettingDateViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.dateMode)
    }
    
    func testDateDisplayInTextMode() {
        let vm = SettingDateViewModel(dateMode: .text)
        XCTAssertEqual(vm.labelText, "Fri, 01 December")
    }
    
    func testDateDisplayInDigitMode() {
        let vm = SettingDateViewModel(dateMode: .digit)
        XCTAssertEqual(vm.labelText, "F, 12/01")
    }
    
    func testTextDateModeSelected() {
        let dateMode: DateMode = .text
        
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        let vm = SettingDateViewModel(dateMode: dateMode)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.checkmark)
    }
    
    func testTextDateModeUnSelected() {
        let dateMode: DateMode = .text
        
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        let vm = SettingDateViewModel(dateMode: .digit)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.none)
    }
    
    func testDigitDateModeSelected() {
        let dateMode: DateMode = .digit
        
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        let vm = SettingDateViewModel(dateMode: dateMode)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.checkmark)
    }
    
    func testDigitDateModeUnSelected() {
        let dateMode: DateMode = .digit
        
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        let vm = SettingDateViewModel(dateMode: .text)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.none)
    }
}
