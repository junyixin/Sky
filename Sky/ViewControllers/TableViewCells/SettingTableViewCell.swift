//
//  SettingTableViewCell.swift
//  Sky
//
//  Created by junyixin on 04/02/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SettingTableViewCell"
    @IBOutlet var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with vm: SettingsRepresentable) {
        label.text = vm.labelText
        accessoryType = vm.accessory
    }
}
