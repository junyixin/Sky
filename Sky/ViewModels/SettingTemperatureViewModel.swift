//
//  SettingTemperatureViewModel.swift
//  Sky
//
//  Created by junyixin on 27/02/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

struct SettingTemperatureViewModel {
    let temperatureMode: TemperatureMode
    
    var labelText: String {
        return temperatureMode == .celsius ? "Celsius" : "Fahrenheit"
    }
    
    var accessory: UITableViewCellAccessoryType {
        if UserDefaults.temperatureMode() == temperatureMode {
            return .checkmark
        }
        
        return .none
    }
}

extension SettingTemperatureViewModel: SettingsRepresentable {}
