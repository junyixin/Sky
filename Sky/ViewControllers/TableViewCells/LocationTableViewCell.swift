//
//  LocationTableViewCell.swift
//  Sky
//
//  Created by junyixin on 2018/5/29.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "LocationCell";
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with vm: LocationRepresentable) {
        label.text = vm.labelText
    }
}
