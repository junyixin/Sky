//
//  SettingDateViewModel.swift
//  Sky
//
//  Created by junyixin on 27/02/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

struct SettingDateViewModel {
    let dateMode: DateMode
    
    var labelText: String {
        return dateMode == .text ? "Fri, 01 December" : "F, 12/01"
    }
    
    var accessory: UITableViewCellAccessoryType {
        if UserDefaults.dateMode() == dateMode {
            return .checkmark
        }
        
        return .none
    }
}

extension SettingDateViewModel: SettingsRepresentable {}
