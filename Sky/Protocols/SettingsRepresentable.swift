//
//  SettingsRepresentable.swift
//  Sky
//
//  Created by junyixin on 27/02/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

protocol SettingsRepresentable {
    var labelText: String { get }
    var accessory: UITableViewCellAccessoryType { get }
}
